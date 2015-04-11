require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  let(:topic) { create(:topic) }
  let(:reply) { create(:reply, topic: topic) }

  describe 'callbacks' do
    it 'should update user read topic after create' do
      user = create(:user)

      user.expects(:update_read_topic)

      create(:reply, user: user, topic: topic)
    end

    it 'should set attributes before validation on create' do
      reply.user_name.must_equal reply.user.name
      reply.user_avatar.must_equal reply.user.avatar
      reply.floor.must_equal 1
    end

    it 'should update topic attributes after create' do
      topic.reload
      reply.reload

      topic.last_replied_user_id.must_equal reply.user.id
      topic.last_replied_user_name.must_equal reply.user.name
      topic.last_replied_at.to_i.must_equal reply.created_at.to_i
      topic.actived_at.to_i.must_equal reply.created_at.to_i
    end

    it 'should create notifications after create' do
      reply.topic.user.notifications.to_a.wont_be_empty
    end
  end

  describe '.page_of_floor' do
    it 'should return page' do
      Reply.page_of_floor(10).must_equal 1
      Reply.page_of_floor(20).must_equal 1
      Reply.page_of_floor(21).must_equal 2
      Reply.page_of_floor(40).must_equal 2
    end
  end

  describe '#has_favorites?' do
    it 'should return true if favorites_count is bigger than 0' do
      reply.favorites_count = 1
      reply.has_favorites?.must_equal true
    end

    it 'should return true if favorites_count is equal to 0' do
      reply.has_favorites?.must_equal false
    end
  end
end
