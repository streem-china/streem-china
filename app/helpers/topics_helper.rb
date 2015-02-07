module TopicsHelper
  def last_reply_link(topic)
    options = {}

    unless topic.replies_count.zero?
      div, mod = topic.replies_count.divmod(Reply.per_page)

      page = mod.zero? ? div : div + 1

      options.merge!(page: page, anchor: "reply-#{topic.replies_count}")
    end

    klass = signed_in? && current_user.has_read_topic?(topic) ? 'label secondary' : 'label'

    link_to topic.replies_count, topic_path(topic, options), class: klass
  end
end
