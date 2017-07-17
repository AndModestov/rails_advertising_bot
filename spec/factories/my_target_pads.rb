FactoryGirl.define do
  factory :my_target_pad, class: 'MyTarget::Pad' do
    sequence(:name) { |n| "pad-#{n}" }
    sequence(:service_id) { |n| 1234 + n }
  end
end
