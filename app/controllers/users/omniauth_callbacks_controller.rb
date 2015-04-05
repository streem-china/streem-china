module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      process(request.env['omniauth.auth'])
    end

    def twitter
      process(request.env['omniauth.auth'])
    end

    private

    def process(auth)
      provider = auth.provider
      uid      = auth.uid
      name     = auth.info.nickname
      email    = auth.info.email
      avatar   = auth.info.image

      if authorization = Authorization.find_by_provider_and_uid(provider, uid)
        user = authorization.user
      else
        user = User.new(
          name: name,
          email: email,
          avatar: avatar)

        user.skip_confirmation!

        user.authorizations.build(provider: provider, uid: uid)

        unless user.save
          flash[:alert] = user.errors.full_messages.join(', ')
          return(redirect_to new_user_session_path)
        end
      end

      set_flash_message(:notice, :success, kind: provider.capitalize)
      sign_in_and_redirect user
    end
  end
end
