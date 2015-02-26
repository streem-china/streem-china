module Favoritable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects
    set :favorited_user_ids
  end

  def favorited_by?(user)
    favorited_user_ids.member?(user.id)
  end
end
