FactoryGirl.define do
  factory :mention do
    user { create(:user) }
    mentionable { create(:topic) }
  end
end

