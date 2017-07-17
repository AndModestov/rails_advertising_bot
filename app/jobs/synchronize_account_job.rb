class SynchronizeAccountJob < ApplicationJob
  queue_as :default

  def perform(account_id)
    account = MyTarget::Account.find(account_id)
    account.set_status 'synchronization in progress'
    publisher = MyTarget::Publisher.new(account.login, account.password, account.link)

    begin
      publisher.authenticate
      MyTarget::Logger.debug 'CreatePad', "Starting..."
      pad_data = publisher.create_pad
      save_pads pad_data
      account.set_status 'synchronized'
    rescue => e
      account.set_status 'synchronization error'
    end
  end

  private

  def save_pads pad_data
    
  end
end
