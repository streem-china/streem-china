class Reply < ActiveRecord::Base
  include Markdownable
  include Mentionable
  include Favoritable

  acts_as_paranoid

  belongs_to :user, counter_cache: true
  belongs_to :topic, counter_cache: true
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :mentions, as: :mentionable, dependent: :destroy
  has_one :notification,
    class_name: 'Notification::Reply',
    dependent: :destroy
  has_many :favorited_reply_notifications,
    class_name: 'Notification::FavoritedReply',
    dependent: :destroy

  validates :user_id, presence: true
  validates :user_name, presence: true
  validates :user_avatar, presence: true
  validates :topic_id, presence: true
  validates :body, presence: true
  validates :floor, presence: true, uniqueness: { scope: :topic_id }

  before_validation :set_attributes_before_validation_on_create, on: :create
  after_create :update_user_read_topic_after_create,
               :update_topic_attributes_after_create,
               :create_notifications_after_create

  def has_favorites?
    !favorites_count.zero?
  end

  def self.page_of_floor(floor)
    div, mod = floor.divmod(per_page)

    mod.zero? ? div : div + 1
  end

  private

  def update_user_read_topic_after_create
    user.update_read_topic(topic)
  end

  def set_attributes_before_validation_on_create
    assign_attributes(
      user_name: user.name,
      user_avatar: user.avatar,
      floor: topic.replies_count + 1
    )
  end

  def update_topic_attributes_after_create
    topic.update_attributes(
      last_replied_user_id: user.id,
      last_replied_user_name: user.name,
      last_replied_at: created_at,
      actived_at: created_at
    )
  end

  def create_notifications_after_create
    unless user_id.eql?(topic.user_id)
      create_notification(user_id: topic.user_id)
    end

    topic.favorites.each do |favorite|
      unless [topic.user_id, user_id].include?(favorite.user_id)
        favorited_reply_notifications.create(user_id: favorite.user_id)
      end
    end
  end
end
