class Topic < ActiveRecord::Base
  include Markdownable

  acts_as_paranoid

  belongs_to :user
  has_many :replies

  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :actived_at, presence: true

  before_validation :set_actived_at, on: :create

  private

  def set_actived_at
    self.actived_at = Time.now
  end
end
