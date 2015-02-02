class Topic < ActiveRecord::Base
  include Markdownable

  acts_as_paranoid

  belongs_to :user
  has_many :replies

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
