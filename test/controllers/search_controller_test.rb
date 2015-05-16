require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  describe 'show' do
    it 'should redirect_to google' do
      get :show, q: 'streem'

      assert_redirected_to SearchController::GOOGLE_SEARCH_URL % 'streem'
    end
  end
end


