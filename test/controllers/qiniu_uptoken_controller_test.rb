require 'test_helper'

class QiniuUptokenControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  before { sign_in create(:user) }

  describe 'uptoken' do
    it 'should respond ok' do
      Qiniu.stubs(:generate_upload_token).returns('uptoken')

      get :show

      response.body.must_equal({ uptoken: 'uptoken'}.to_json)

      assert_response :ok
    end
  end
end

