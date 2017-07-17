class MyTarget::Pad < ApplicationRecord
  belongs_to :account, class_name: 'MyTarget::Account'
  has_many :addunits, foreign_key: 'pad_id', class_name: 'MyTarget::Addunit', dependent: :destroy

  validates :name, :service_id, :account_id, presence: true
end
