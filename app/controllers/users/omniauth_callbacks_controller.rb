module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      auth = request.env['omniauth.auth']

      provider = auth.provider
      uid      = auth.uid
      name     = auth.info.name
      email    = auth.info.email
      avatar   = auth.info.image

      if authorization = Authorization.find_by_provider_and_uid(provider, uid)
        authorization.user.update_attributes(
          name: name,
          email: email,
          avatar: avatar)

        user = authorization.user
      else
        user = User.new(
          name: name,
          email: email,
          avatar: avatar)

        user.authorization = Authorization.new(
          provider: provider,
          uid: uid)

        user.save!
      end

      sign_in_and_redirect user

      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    end
  end
end
