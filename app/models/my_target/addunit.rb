class MyTarget::Addunit < ApplicationRecord
  belongs_to :pad, class_name: 'MyTarget::Pad'

  validates :name, :service_id, :pad_id, :format, presence: true
end
