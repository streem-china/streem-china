class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true, counter_cache: true
  belongs_to :user, counter_cache: true
  has_one :notification, class_name: 'Notification::Favorite', dependent: :destroy

  validates :user_id,
    presence: true,
    uniqueness: { scope: [:favoritable_id, :favoritable_type] }
  validates :favoritable_id, presence: true
  validates :favoritable_type, presence: true

  after_destroy :destroy_from_redis_after_destroy
  after_create :create_to_redis_after_create,
               :create_notification_after_create

  private

  def create_to_redis_after_create
    favoritable.favorited_user_ids.add(user_id)
  end

  def destroy_from_redis_after_destroy
    favoritable.favorited_user_ids.delete(user_id)
  end

  def create_notification_after_create
    return if user_id.eql?(favoritable.user_id)

    create_notification(user_id: favoritable.user_id)
  end
end
