class MyTarget::Account < ApplicationRecord
  validates :name, :link, :password, :login, presence: true
  validates :password, length: { minimum: 6 }
  validates :login, format: /@/
  
end
