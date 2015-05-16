require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }
  let(:topic) { create :topic }

  describe 'create' do
    it 'should respond created' do
      post :create, favoritable_id: topic.id, favoritable_type: 'Topic'

      assert_response :created
    end
  end

  describe 'destroy' do
    let(:favorite) { create(:favorite, user: user) }

    it 'should respond no_content with id' do
      delete :destroy, id: favorite.id

      assert_response :no_content
    end

    it 'should respond no_content with favoritable_id and favoritable_type' do
      delete :destroy,
        favoritable_id: favorite.favoritable_id,
        favoritable_type: favorite.favoritable_type

      assert_response :no_content
    end

    it 'should respond :not_found if no favorite found' do
      delete :destroy, id: 0

      assert_response :not_found
    end
  end
end

