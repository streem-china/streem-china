class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :provider, inclusion: { in: %w(github twitter) }, uniqueness: { scope: :uid }
  validates :uid, presence: true
end
