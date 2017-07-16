class SynchronizeAccountJob < ApplicationJob
  queue_as :default

  def perform(account_id)
    account = MyTarget::Account.find account_id
    account.set_status 'synchronization in progress'
  end
end
