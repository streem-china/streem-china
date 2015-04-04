module TopicsHelper
  def replies_count_link(topic)
    options = {}

    if topic.has_replies?
      page = Reply.page_of_floor(topic.replies_count)

      options.merge!(page: page, anchor: "reply-#{topic.replies_count}")
    end

    klass = signed_in? && current_user.has_read_topic?(topic) ? 'label secondary' : 'label'

    link_to topic.replies_count, topic_path(topic, options), class: klass
  end

  def reply_link(reply)
    page = Reply.page_of_floor(reply.floor)

    text = "##{reply.floor}#{t('activerecord.attributes.reply.floor')}"
    anchor = "reply-#{reply.floor}"

    link_to text, topic_path(reply.topic, page: page, anchor: anchor)
  end

  def favorited_link(favoritable)
    link_to '#', class: 'fa fa-heart favorited',
                 data: { favoritable_id: favoritable.id,
                         favoritable_type: favoritable.class.name } do
      content_tag :span, favoritable.favorites_count, class: 'count'
    end
  end

  def unfavorited_link(favoritable)
    link_to '#', class: 'fa fa-heart-o unfavorited',
                 data: { favoritable_id: favoritable.id,
                         favoritable_type: favoritable.class.name } do
      content_tag :span, favoritable.favorites_count, class: 'count'
    end
  end
end
