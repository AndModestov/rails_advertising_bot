FactoryGirl.define do
  factory :my_target_addunit, class: 'MyTarget::Addunit' do
    sequence(:name) { |n| "addunit-#{n}" }
    sequence(:service_id) { |n| 5678 + n }
  end
end
