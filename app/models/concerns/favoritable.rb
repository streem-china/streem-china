module Favoritable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects
    set :favorited_user_ids
  end

  def favorited_by?(user)
    favorited_user_ids.member?(user.id)
  end

  def favorited_by(user)
    user.favorites.create(
      favoritable_id: id,
      favoritable_type: self.class.name
    )
  end
end
