class AccountsChannel < ApplicationCable::Channel
  def follow
    stream_from "accounts"
  end
end
