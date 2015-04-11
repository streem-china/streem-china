FactoryGirl.define do
  factory :favorite do
    user { create(:user) }
    favoritable { create(:topic) }
  end
end


