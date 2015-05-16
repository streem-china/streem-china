require 'test_helper'

class MarkdownPreviewControllerTest < ActionController::TestCase
  describe 'show' do
    it 'should respond json content' do
      post :show, text: '### H3'

      assert_response :ok

      response.body.must_equal({ html: Markdowner.render('### H3')}.to_json)
    end
  end
end


