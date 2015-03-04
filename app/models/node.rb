class Node < ActiveRecord::Base
  has_many :topics

  validates :name, presence: true, uniqueness: true
end
