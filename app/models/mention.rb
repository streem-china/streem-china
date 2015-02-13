class Mention < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :mentionable, polymorphic: true

  validates :sender_id, presence: true, uniqueness: { scope: [:mentionable_id, :mentionable_type, :receiver_id] }
  validates :receiver_id, presence: true
  validates :mentionable_id, presence: true
  validates :mentionable_type, presence: true

  validate :sender_id do
    if sender_id.eql?(receiver_id)
      errors.add(:sender_id, "can't equal to receiver_id")
    end
  end
end
