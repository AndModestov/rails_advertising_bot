class ActionCablePublisher

  def self.publish_account action, account_id
    account =
      if action != 'delete'
        acc = MyTarget::Account.find account_id
        ApplicationController.render(
          partial: 'my_target/accounts/account_data',
          locals: { account: acc }
        )
      else
        nil
      end

    ActionCable.server.broadcast(
      'accounts',
      id: account_id,
      action: action,
      account: account
    )
  end
end
