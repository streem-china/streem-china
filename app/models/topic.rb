class Topic < ActiveRecord::Base
  include Markdownable

  belongs_to :user
  has_many :replies

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  acts_as_paranoid
end
