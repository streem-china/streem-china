module Users
  class SessionsController < Devise::SessionsController
    respond_to :html, :js
  end
end
