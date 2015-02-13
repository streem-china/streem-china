module Mentionable
  extend ActiveSupport::Concern

  included do
    after_save { parse_mention_from_body if body_changed? }
  end

  private

  def parse_mention_from_body
    receiver_ids = []

    body.gsub!(/@(\w+)/) do |match|
      if receiver = User.find_by_name($1)
        unless receiver.id.eql?(user_id) || receiver_ids.include?(receiver.id)
          receiver_ids << receiver.id
        end
      end
    end

    create_new_mentions(receiver_ids)

    delete_old_mentions(receiver_ids)
  end

  def create_new_mentions(receiver_ids)
    receiver_ids.each do |receiver_id|
      mentions.create(receiver_id: receiver_id, sender_id: user_id)
    end
  end

  def delete_old_mentions(receiver_ids)
    if receiver_ids.present?
      mentions.
        where(sender_id: user_id).
        where("receiver_id not in (#{receiver_ids.join(', ')})").
        destroy_all
    else
      mentions.where(sender_id: user_id).destroy_all
    end
  end
end
