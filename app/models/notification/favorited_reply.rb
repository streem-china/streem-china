module Notification
  class FavoritedReply < Base
    belongs_to :reply, class_name: '::Reply'
  end
end
