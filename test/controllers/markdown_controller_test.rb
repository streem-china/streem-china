require 'test_helper'

class MarkdownControllerTest < ActionController::TestCase
  describe 'convert' do
    it 'should respond json content' do
      post :convert, text: '### H3'

      assert_response :ok

      response.body.must_equal({ html: Markdowner.render('### H3')}.to_json)
    end
  end
end


