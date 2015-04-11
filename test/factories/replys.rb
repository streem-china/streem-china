FactoryGirl.define do
  factory :reply do
    body '### Streem China'
    topic { create(:topic) }
    user { create(:user) }
  end
end
