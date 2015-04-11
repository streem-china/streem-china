FactoryGirl.define do
  factory :topic do
    title 'Streem'
    body '### Streem Language'
    body_html nil
    user { create(:user) }
    node { create(:node) }
  end
end
