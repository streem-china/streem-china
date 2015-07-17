module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        session_key = Rails.application.config.session_options[:key]
        warden_user_user_value = cookies.encrypted[session_key]['warden.user.user.key']

        return unless warden_user_user_value

        user_id = warden_user_user_value.first.first

        if current_user = User.find(user_id)
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
