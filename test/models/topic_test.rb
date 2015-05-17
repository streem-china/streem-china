require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  let(:topic) { create(:topic) }

  describe 'callbacks' do
    it 'should set attributes before validation' do
      topic.user_name.must_equal topic.user.name
      topic.user_avatar.must_equal topic.user.avatar
      topic.actived_at.wont_be_nil
    end

    it 'should set node_name before validation' do
      topic.node_name.must_equal topic.node.name
    end

    it 'should set user read topic after create' do
      user = create(:user)

      user.expects(:update_read_topic)

      create(:topic, user: user, node: create(:node))
    end
  end

  describe '#has_replies?' do
    it 'should return true if replies_count is bigger than 0' do
      topic.replies_count = 1
      topic.has_replies?.must_equal true
    end

    it 'should return true if replies_count is equal to 0' do
      topic.has_replies?.must_equal false
    end
  end

  describe '#has_favorites?' do
    it 'should return true if favorites_count is bigger than 0' do
      topic.favorites_count = 1
      topic.has_favorites?.must_equal true
    end

    it 'should return true if favorites_count is equal to 0' do
      topic.has_favorites?.must_equal false
    end
  end

  describe '#stick?' do
    it 'should return false' do
      topic.stick.must_equal false
    end
  end

  describe '#stick!' do
    it 'should set to be stick' do
      topic.stick!

      topic.stick.must_equal true
    end
  end

  describe '#unstick!' do
    it 'should set to be unstick' do
      topic.unstick!

      topic.stick.must_equal false
    end
  end

  describe '#node_others' do
    it 'should not be empty' do
      create(:topic, node: topic.node, user: topic.user)

      topic.node_others(5).wont_be_empty
    end
  end

  describe '#user_others' do
    it 'should not be empty' do
      create(:topic, node: topic.node, user: topic.user)

      topic.node_others(5).wont_be_empty
    end
  end

  describe '#others' do
    it 'should not be empty' do
      create(:topic, node: topic.node, user: topic.user)

      topic.send(:others, 5, node_id: topic.node_id).wont_be_empty
    end
  end
end

