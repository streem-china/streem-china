require 'test_helper'

describe Notification::Base do
  let(:notification) { create(:notification) }

  describe 'callbacks' do
    it 'should user increase unread notifications count after create' do
      notification.user.unread_notifications_count.must_equal 1
    end

    it 'should user decrease unread notifications count after destroy' do
      user = notification.user

      notification.destroy

      user.unread_notifications_count.must_equal 0
    end

    it 'should user update unread notifications count after update' do
      notification.read!

      notification.user.unread_notifications_count.must_equal 0
    end
  end

  describe '#read?' do
    it 'should return false' do
      notification.read?.must_equal false
    end
  end

  describe '#unread?' do
    it 'should return true' do
      notification.unread?.must_equal true
    end
  end

  describe '#read!' do
    it 'should update read to true' do
      notification.read!
      notification.read.must_equal true
    end
  end

  describe '#unread!' do
    it 'should update read to false' do
      notification.unread!
      notification.read.must_equal false
    end
  end
end
