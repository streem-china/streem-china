module Mentionable
  extend ActiveSupport::Concern

  included do
    after_save { parse_mention_from_body if body_changed? }
  end

  private

  def parse_mention_from_body
    user_ids = []

    body.gsub!(/@(\w+)/) do |match|
      if user = User.find_by_name($1)
        unless user_ids.include?(user.id)
          user_ids << user.id
        end
      end
    end

    if user_ids.present?
      create_new_mentions(user_ids)
    end

    delete_old_mentions(user_ids)
  end

  def create_new_mentions(user_ids)
    user_ids.each do |user_id|
      mentions.create(user_id: user_id)
    end
  end

  def delete_old_mentions(user_ids)
    if user_ids.present?
      mentions.where("user_id not in (#{user_ids.join(', ')})").destroy_all
    else
      mentions.destroy_all
    end
  end
end
