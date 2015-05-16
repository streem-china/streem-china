require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  describe 'update' do
    before { sign_in create(:user) }

    it 'should respond no_content' do
      put :update, avatar: 'http://streem-china.org/avatar.png'

      assert_response :no_content
    end
  end
end
