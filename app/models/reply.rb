class Reply < ActiveRecord::Base
  include Markdownable

  self.per_page = 20

  acts_as_paranoid

  belongs_to :user
  belongs_to :topic, counter_cache: true

  validates :user_id, presence: true
  validates :user_name, presence: true
  validates :user_avatar, presence: true
  validates :topic_id, presence: true
  validates :body, presence: true
  validates :floor, presence: true, uniqueness: { scope: :topic_id }

  before_validation :set_attributes_beofre_validation_on_create, on: :create
  after_create :update_topic_attributes_after_create
  after_create :update_user_read_topic_after_create

  def self.page_of_floor(floor)
    div, mod = floor.divmod(per_page)

    mod.zero? ? div : div + 1
  end

  private

  def set_attributes_beofre_validation_on_create
    self.user_name = user.name
    self.user_avatar = user.avatar
    self.floor = topic.replies_count + 1
  end

  def update_user_read_topic_after_create
    user.update_read_topic(topic)
  end

  def update_topic_attributes_after_create
    topic.update_attributes(
      last_replied_user_id: user.id,
      last_replied_user_name: user.name,
      last_replied_at: created_at,
      actived_at: created_at
    )
  end
end
