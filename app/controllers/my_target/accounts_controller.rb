class MyTarget::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy, :synchronize]

  def index
    @accounts = MyTarget::Account.all
  end

  def show
  end

  def create
    @account = MyTarget::Account.new(account_params)
    if @account.save
      ActionCablePublisher.publish_account('create', @account.id)
    else
      render_errors
    end
  end

  def update
    if @account.update(account_params)
      ActionCablePublisher.publish_account('update', @account.id)
    else
      render_errors
    end
  end

  def destroy
    @account.destroy
    ActionCablePublisher.publish_account('delete', @account.id)
  end

  def synchronize
    SynchronizeAccountJob.perform_later(@account.id)
  end


  private

  def render_errors
    render json: @account.errors.full_messages, status: :unprocessable_entity
  end

  def set_account
    @account = MyTarget::Account.find(params[:id])
  end

  def account_params
    params.require(:my_target_account).permit(:name, :login, :password, :link)
  end
end
