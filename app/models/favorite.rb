class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :user_id, presence: true, uniqueness: { scope: [:favoritable_id, :favoritable_type] }
  validates :favoritable_id, presence: true
  validates :favoritable_type, presence: true
end
