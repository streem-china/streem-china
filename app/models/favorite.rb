class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true, counter_cache: true
  belongs_to :user, counter_cache: true
  has_one :notification, class_name: 'Notification::Favorite', dependent: :destroy

  validates :user_id,
    presence: true,
    uniqueness: { scope: [:favoritable_id, :favoritable_type] }
  validates :favoritable_id, presence: true
  validates :favoritable_type, presence: true, inclusion: %w(Topic Reply)

  after_create :create_to_redis_after_create,
               :create_notification_after_create
  after_destroy :destroy_from_redis_after_destroy
  after_destroy :decrement_counter_after_destory, unless: :favoritable

  private

  def create_to_redis_after_create
    favoritable.favorited_user_ids.add(user_id)
  end

  def create_notification_after_create
    return if user_id.eql?(favoritable.user_id)

    create_notification(user_id: favoritable.user_id)
  end

  def destroy_from_redis_after_destroy
    favoritable_type.
      constantize.
      unscoped.
      find_by_id(favoritable_id).
      favorited_user_ids.
      delete(user_id)
  end


  def decrement_counter_after_destory
    favoritable_type.
      constantize.
      unscoped.
      decrement_counter(:favorites_count, favoritable_id)
  end
end
