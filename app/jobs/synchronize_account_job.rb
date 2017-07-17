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
      save_pads pad_data, account
      account.set_status 'synchronized'
    rescue => e
      account.set_status 'synchronization error'
      MyTarget::Logger.debug e.message, e.backtrace
    end
  end

  private

  def save_pads pad_data, account
    pad = account.pads.create pad_data[:app]
    pad_data[:addunits].each do |unit|
      pad.addunits.create unit
    end
  end
end
