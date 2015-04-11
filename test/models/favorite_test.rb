require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  describe 'callbacks' do
    let(:user) { create(:user) }
    let(:favorite) { create(:favorite, user: user) }

    it 'should create to redis after create' do
      favorite.favoritable.favorited_user_ids.must_include(user.id)
    end

    it 'should describe from redis after destroy' do
      favoritable = favorite.favoritable
      favorite.destroy
      favoritable.favorited_user_ids.wont_include(user.id)
    end

    it 'should create notification after create' do
      favorite.favoritable.user.notifications.to_a.wont_be_empty
    end
  end
end
