FactoryGirl.define do
  factory :notification, class: 'Notification::Reply' do
    user { create(:user) }
  end
end

