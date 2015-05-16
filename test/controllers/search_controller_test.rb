require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  describe 'perform' do
    it 'should redirect_to google' do
      get :perform, q: 'streem'

      assert_redirected_to SearchController::GOOGLE_SEARCH_URL % 'streem'
    end
  end
end


