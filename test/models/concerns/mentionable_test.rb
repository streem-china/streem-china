require 'test_helper'

class MentionableTest < ActiveSupport::TestCase
  let(:topic) { create(:topic) }

  describe 'callbacks' do
    it 'should parse mention from body after save if body changed' do
      user = create(:user, name: 'streem')
      topic.update_attributes(body: '@streem')
      user.mentions.to_a.wont_be_empty
    end
  end

  describe '#parse_mention_from_body' do
    it 'should call create_new_mentions with present user_ids params' do
      user = create(:user, name: 'streem')
      topic.expects(:create_new_mentions).with([user.id])
      topic.body = '@streem'
      topic.send(:parse_mention_from_body)
    end

    it 'should not call create_new_mentions' do
      user = create(:user, name: 'streem')
      topic.expects(:create_new_mentions).never
      topic.body = '@nobody'
      topic.send(:parse_mention_from_body)
    end
  end

  describe '#create_new_mentions' do
    it 'should create mention by user_ids' do
      user = create(:user, name: 'streem')
      topic.send(:create_new_mentions, [user.id])
      user.mentions.to_a.wont_be_empty
    end
  end

  describe '#delete_old_mentions' do
    it 'should delete mentions by user_ids' do
      topic.mentions.create(user: create(:user))
      topic.send(:delete_old_mentions, [])
      topic.mentions.to_a.must_be_empty
    end
  end
end

