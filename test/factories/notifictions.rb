FactoryGirl.define do
  factory :notification, class: 'Notification::Reply' do
    reply { create(:reply) }
    user { create(:user) }
  end
end

