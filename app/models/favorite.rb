class Favorite < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: { scope: [:favoritable_id, :favoritable_type] }
  validates :favoritable_id, presence: true
  validates :favoritable_type, presence: true

  belongs_to :favoritable, polymorphic: true
end
