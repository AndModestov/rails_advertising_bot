class MyTarget::Account < ApplicationRecord
  validates :name, :link, :password, :login, presence: true
  validates :password, length: { minimum: 6 }
  validates :login, format: /@/

  enum status: {
    'not synchronized'=>0, 'synchronization in progress'=>1, 'synchronization error'=>2, 'synchronized'=>3
  }

  def set_status status
    self.update status: status
  end
end
