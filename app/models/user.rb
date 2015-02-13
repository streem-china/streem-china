class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:github]

  has_one :authorization
  has_many :topics
  has_many :replies
  has_many :favorites
  has_many :received_mentions, foreign_key: :receiver_id, class_name: 'Mention'
  has_many :sent_mentions, foreign_key: :sender_id, class_name: 'Mention'

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  include Redis::Objects
  hash_key :read_topics

  def update_read_topic(topic, ts=Time.now.to_i)
    read_topics[topic.id] = ts.to_i
  end

  def has_read_topic?(topic)
    read_topics[topic.id].to_i >= topic.actived_at.to_i
  end

  def favorited?(favoritable)
    favorites.exists?(favoritable_id: favoritable.id,
                      favoritable_type: favoritable.class.to_s)
  end
end
