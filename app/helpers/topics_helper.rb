module TopicsHelper
  def replies_count_link(topic)
    options = {}

    unless topic.replies_count.zero?
      page = Reply.page_of_floor(topic.replies_count)

      options.merge!(page: page, anchor: "reply-#{topic.replies_count}")
    end

    klass = signed_in? && current_user.has_read_topic?(topic) ? 'label secondary' : 'label'

    link_to topic.replies_count, topic_path(topic, options), class: klass
  end

  def reply_link(reply)
    if reply.topic
      page = Reply.page_of_floor(reply.floor)

      text = "##{reply.floor}#{t('activerecord.attributes.reply.floor')}"

      link_to text, topic_path(reply.topic, page: page, anchor: "reply-#{reply.floor}")
    else
      link_to text, '#'
    end
  end
end
