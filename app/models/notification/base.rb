module Notification
  class Base < ActiveRecord::Base
    self.table_name = 'notifications'

    belongs_to :user, counter_cache: :notifications_count

    after_create :increase_user_unread_notifications_count_after_create
    after_destroy :decrease_user_unread_notifications_count_after_destroy
    after_update :update_user_unread_notifications_count_after_update

    def read?
      read
    end

    def unread?
      !read?
    end

    def unread!
      update_attributes(read: false)
    end

    def read!
      update_attributes(read: true)
    end

    private

    def increase_user_unread_notifications_count_after_create
      user.increment!(:unread_notifications_count)
    end

    def decrease_user_unread_notifications_count_after_destroy
      user.decrement!(:unread_notifications_count) if unread?
    end

    def update_user_unread_notifications_count_after_update
      if read_changed? && read?
        user.decrement!(:unread_notifications_count)
      elsif read_changed? && unread?
        user.increment!(:unread_notifications_count)
      end
    end
  end
end

