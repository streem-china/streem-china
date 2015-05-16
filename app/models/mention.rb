class Mention < ActiveRecord::Base
  belongs_to :user
  belongs_to :mentionable, polymorphic: true
  has_one :notification, class_name: 'Notification::Mention'

  validates :user_id,
    presence: true,
    uniqueness: { scope: [:mentionable_id, :mentionable_type] }
  validates :mentionable_id, presence: true
  validates :mentionable_type, presence: true

  after_create :create_notification_after_create

  private

  def create_notification_after_create
    return if user_id.eql?(mentionable.user_id)
    return if mentionable.is_a?(Reply) && user_id.eql?(mentionable.topic.user_id)

    create_notification(user_id: user_id)
  end
end
