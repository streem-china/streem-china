module TopicReadable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects
    hash_key :read_topics
  end

  def update_read_topic(topic, ts=Time.now.to_i)
    read_topics[topic.id] = ts.to_i
  end

  def has_read_topic?(topic)
    read_topics[topic.id].to_i >= topic.actived_at.to_i
  end
end
