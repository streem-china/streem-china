module Notification
  class Mention < Base
    belongs_to :mention, class_name: '::Mention'
  end
end
