require 'test_helper'

class TopicReadableTest < ActiveSupport::TestCase
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  describe '#update_read_topic' do
    it 'should update read_topics' do
      user.update_read_topic(topic)

      user.read_topics[topic.id].wont_be_nil
    end
  end

  describe '#has_read_topic?' do
    it 'should return false' do
      user.has_read_topic?(topic).must_equal false
    end
  end
end
