class Topic < ActiveRecord::Base
  include Markdownable

  belongs_to :user
  belongs_to :last_replied_user, class_name: 'User', foreign_key: 'last_replied_user_id'
  has_many :replies

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  acts_as_paranoid
end
