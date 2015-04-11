require 'test_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'should be invalid if name is too long' do
      user = build(:user, name: 'streem' * 5)
      user.valid?.must_equal false
      user.errors.messages[:name].wont_be_empty
    end

    it 'should be invalid if name is too short' do
      user = build(:user, name: 's')
      user.valid?.must_equal false
      user.errors.messages[:name].wont_be_empty
    end

    it 'should be invalid if name is has special character *' do
      user = build(:user, name: 'streem*')
      user.valid?.must_equal false
      user.errors.messages[:name].wont_be_empty
    end

    it 'should be invalid if name is has special character -' do
      user = build(:user, name: 'streem-')
      user.valid?.must_equal false
      user.errors.messages[:name].wont_be_empty
    end

    it 'should be invalid if name is has special character blank' do
      user = build(:user, name: 'streem china')
      user.valid?.must_equal false
      user.errors.messages[:name].wont_be_empty
    end
  end

  describe 'callbacks' do
    it 'should set default avatar after save' do
      user = build(:user, avatar: nil)
      user.save
      user.avatar.must_equal User::DEFAULT_AVATAR
    end

    it 'should set topics and replies user avatar' do
      node = create(:node)
      topic = create(:topic, user: user, node: node)
      reply = create(:reply, user: user, topic: topic)

      user.update_attributes(avatar: 'another.png')

      topic.reload
      reply.reload

      topic.user_avatar.must_equal 'another.png'
      reply.user_avatar.must_equal 'another.png'
    end
  end

  describe '.find_for_database_authentication' do
    before { create(:user) }

    it 'should return a user by email login' do
      user = User.find_for_database_authentication(login: 'us@streem-china.org')
      user.must_be_kind_of User
    end

    it 'should return a user by name login' do
      user = User.find_for_database_authentication(login: 'streem')
      user.must_be_kind_of User
    end

    it 'should return nil when login not exists' do
      user = User.find_for_database_authentication(login: 'whatever')
      user.must_be_nil
    end
  end

  describe '#has_unread_notifications?' do
    it 'should be true if unread_notifications_count is bigger than 0' do
      user.unread_notifications_count = 1
      user.has_unread_notifications?.must_equal true
    end

    it 'should be false if unread_notifications_count is 0' do
      user.has_unread_notifications?.must_equal false
    end
  end

  describe '#has_avatar?' do
    it 'should be true if user has has avatar' do
      user.has_avatar?.must_equal true
    end

    it 'should be false if user has authorization' do
      user.authorization = build(:authorization)
      user.email_required?.must_equal false
    end
  end

  describe '#password_required?' do
    it 'should be true if user has no authorization' do
      user.password_required?.must_equal true
    end

    it 'should be false if user has authorization' do
      user.authorization = build(:authorization)
      user.password_required?.must_equal false
    end
  end

  describe '#email_required?' do
    it 'should be true if user has no authorization' do
      user.email_required?.must_equal true
    end

    it 'should be false if user has authorization' do
      user.authorization = build(:authorization)
      user.email_required?.must_equal false
    end
  end
end
