FactoryGirl.define do
  factory :authorization do
    provider 'github'
    uid { SecureRandom.hex(4) }
  end
end
