FactoryGirl.define do
  factory :user do
    name 'streem'
    avatar 'http://streem-china.org/avatar.png'
    email 'us@streem-china.org'
    password '123456'

    confirmed_at Time.now
  end
end
