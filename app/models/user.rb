class User < ActiveRecord::Base
  DEFAULT_AVATAR = '/images/avatar.png'

  include TopicReadable

  attr_accessor :login

  devise :database_authenticatable,
         :registerable,
         :omniauthable,
         :validatable,
         :recoverable,
         :confirmable,
         :trackable,
         :rememberable,
         authentication_keys: [:login],
         omniauth_providers: [:github]

  has_many :authorizations
  has_many :topics
  has_many :replies
  has_many :favorites
  has_many :mentions
  has_many :notifications, class_name: 'Notification::Base'

  validates :name,
    uniqueness: { case_sensitive: false },
    length: { in: 3..20 },
    format: { with: /\A\w+\z/ }

  before_save :set_default_avatar_before_save
  after_update :set_topics_and_replies_user_avatar_after_update, if: :avatar_changed?

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup

    login = conditions.delete(:login)

    where(conditions).
      where('lower(name) = :value OR lower(email) = :value', { value: login.downcase }).
      first
  end

  def has_unread_notifications?
    unread_notifications_count > 0
  end

  def password_required?
    (authorizations.blank? || password.present?) && super
  end

  private

  def set_default_avatar_before_save
    self.avatar = DEFAULT_AVATAR if avatar.blank?
  end

  def set_topics_and_replies_user_avatar_after_update
    topics.update_all(user_avatar: avatar)
    replies.update_all(user_avatar: avatar)
  end
end
