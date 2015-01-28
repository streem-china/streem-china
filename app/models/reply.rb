class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, counter_cache: true

  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :body, presence: true
end
