require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'index' do
    it 'should respond ok' do
      create :notification, user: user

      get :index

      assigns(:notifications).wont_be_empty

      assert_response :ok
    end
  end
end



