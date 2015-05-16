require 'test_helper'

class QiniuControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  before { sign_in create(:user) }

  describe 'uptoken' do
    it 'should respond ok' do
      Qiniu.stubs(:generate_upload_token).returns('uptoken')

      get :uptoken

      response.body.must_equal({ uptoken: 'uptoken'}.to_json)

      assert_response :ok
    end
  end
end

