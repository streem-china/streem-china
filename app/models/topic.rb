class Topic < ActiveRecord::Base
  include Markdownable
  include Mentionable
  include Favoritable

  acts_as_paranoid

  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true
  has_many :replies
  has_many :favorites, as: :favoritable
  has_many :mentions, as: :mentionable

  validates :user_id, presence: true
  validates :user_name, presence: true
  validates :user_avatar, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :actived_at, presence: true
  validates :node_id, presence: true

  before_validation :set_attributes_before_validation, on: :create
  before_validation :set_node_name_before_validation
  after_create :update_user_read_topic_after_create

  def stick?
    stick
  end

  def stick!
    update_attributes(stick: true)
  end

  def unstick!
    update_attributes(stick: false)
  end

  def has_replies?
    !replies_count.zero?
  end

  def has_favorites?
    !favorites_count.zero?
  end

  def node_others(count=0)
    self.class.
      where(node_id: node_id).
      where('id != ?', id).
      order(id: :desc).
      first(count)
  end

  def user_others(count=0)
    self.class.
      where(user: user_id).
      where('id != ?', id).
      order(id: :desc).
      first(count)
  end

  private

  def set_attributes_before_validation
    assign_attributes(
      user_name: user.name,
      user_avatar: user.avatar,
      actived_at: Time.now
    )
  end

  def set_node_name_before_validation
    self.node_name = node.name if node_id_changed?
  end

  def update_user_read_topic_after_create
    user.update_read_topic(self)
  end
end
