module Notification
  class Favorite < Base
    belongs_to :favorite, class_name: '::Favorite'
  end
end

