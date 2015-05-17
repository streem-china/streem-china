require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  describe 'callbacks' do
    let(:user) { create(:user) }
    let(:favorite) { create(:favorite, user: user) }

    it 'should create to redis after create' do
      favorite.favoritable.favorited_user_ids.must_include(user.id)
    end

    it 'should destroy from redis after destroy' do
      favoritable = favorite.favoritable
      favorite.destroy
      favoritable.favorited_user_ids.wont_include(user.id)
    end

    it 'should create notification after create' do
      favorite.favoritable.user.notifications.to_a.wont_be_empty
    end

    it 'should decrement counter after destroy unless favoritable exists' do
      favoritable = favorite.
        favoritable_type.
        constantize.
        unscoped.
        find(favorite.favoritable_id)

      favoritable.destroy

      favorite.destroy

      favoritable.reload

      favoritable.favorites_count.must_equal 0
    end
  end
end
