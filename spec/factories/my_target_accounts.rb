FactoryGirl.define do

  factory :my_target_account, class: 'MyTarget::Account' do
    sequence(:name) { |n| "acc-name-#{n}" }
    sequence(:login) { |n| "acc-name-#{n}@test.com" }
    password '12345678'
    sequence(:link) { |n| "http://acc-link-#{n}" }
  end

  factory :invalid_my_target_account, class: 'MyTarget::Account' do
    name nil
    login nil
    password nil
    link nil
  end
end
