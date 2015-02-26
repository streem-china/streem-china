module Notification
  class Reply < Base
    belongs_to :reply, class_name: '::Reply'
  end
end
