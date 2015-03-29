module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    def configure_permitted_parameters
      permited_params = %i(name email password password_confirmation)

      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(*permited_params) }
    end
  end
end

