class ProfilesController < ApplicationController
  def edit
    @profile = current_user.profile || current_user.build_profile
  end

  def update
    current_user.profile.update_attributes(profile_params)

    flash[:success] = t('profile.updated_success')

    redirect_to user_path(current_user.name)
  end

  def create
    current_user.create_profile(profile_params)

    flash[:success] = t('profile.updated_success')

    redirect_to user_path(current_user.name)
  end

  private

  def profile_params
    params.require(:profile).permit(:blog_link,
                                    :github_link,
                                    :twitter_link,
                                    :company,
                                    :location)
  end
end
