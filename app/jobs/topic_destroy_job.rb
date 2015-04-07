class TopicDestroyJob < ActiveJob::Base
  queue_as :default

  def perform(topic_id)
    topic = Topic.find_by_id(topic_id)

    topic.destroy if topic
  end
end
