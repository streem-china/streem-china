class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:github]

  has_one :authorization
  has_many :topics
  has_many :replies

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
