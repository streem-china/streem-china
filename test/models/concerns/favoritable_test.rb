require 'test_helper'

class FavoritableTest < ActiveSupport::TestCase
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  describe 'favorited_by?' do
    it 'should return false when user has not favorited it' do
      topic.favorited_by?(user).must_equal false
    end
  end

  describe 'favorited_by' do
    it 'should create a favorite' do
      topic.favorited_by(user)

      topic.favorites.to_a.wont_be_empty
    end
  end
end
