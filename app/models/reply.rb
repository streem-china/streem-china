class Reply < ActiveRecord::Base
  include Markdownable

  belongs_to :user
  belongs_to :topic, counter_cache: true

  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :body, presence: true

  acts_as_paranoid

  after_create :update_topic_last_replied_user_id_and_last_replied_at_after_create

  def update_topic_last_replied_user_id_and_last_replied_at_after_create
    topic.update_attributes(
      last_replied_user_id: user_id,
      last_replied_at: created_at
    )
  end
end
