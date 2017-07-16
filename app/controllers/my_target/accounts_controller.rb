class MyTarget::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]

  def index
    @accounts = MyTarget::Account.all
  end

  def show
  end

  def create
    @account = MyTarget::Account.new(account_params)
    if @account.save
      publish_account 'create'
    else
      render_errors
    end
  end

  def update
    if @account.update(account_params)
      publish_account 'update'
    else
      render_errors
    end
  end

  def destroy
    @account.destroy
    publish_account 'delete'
  end


  private

  def render_errors
    render json: @account.errors.full_messages, status: :unprocessable_entity
  end

  def publish_account action
    ActionCable.server.broadcast(
      'accounts',
      id: @account.id,
      action: action,
      account: ApplicationController.render(
        partial: 'my_target/accounts/account_data',
        locals: { account: @account }
      )
    )
  end

  def set_account
    @account = MyTarget::Account.find(params[:id])
  end

  def account_params
    params.require(:my_target_account).permit(:name, :login, :password, :link)
  end
end
