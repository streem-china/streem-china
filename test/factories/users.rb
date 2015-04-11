FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "streem#{n}"
    end
    sequence :email do |n|
      "#{n}@streem-china.org"
    end
    avatar 'http://streem-china.org/avatar.png'
    password '123456'

    confirmed_at Time.now
  end
end
