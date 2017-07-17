require 'rails_helper'

RSpec.describe MyTarget::AccountsController, type: :controller do
  let!(:account) { create(:my_target_account) }


  describe 'GET #index' do
    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end

    it 'assigns all accounts to @accounts' do
      expect(assigns(:accounts)).to eq MyTarget::Account.all
    end
  end


  describe 'GET #show' do
    before { get :show, params: {id: account} }

    it 'assigns the requested account to @account' do
      expect(assigns(:account)).to eq account
    end

    it 'should render the show view' do
      expect(response).to render_template :show
    end
  end


  describe 'POST #create' do
    context 'with valid data' do
      it 'saves the account in database' do
        expect {
          post :create, params: { my_target_account: attributes_for(:my_target_account) }, format: :js
        }.to change(MyTarget::Account, :count).by(1)
      end

      it 'publishes account to /accounts' do
        expect(ActionCablePublisher).to receive(:publish_account).with('create', anything)
        post :create, params: { my_target_account: attributes_for(:my_target_account) }, format: :js
      end
    end

    context 'with invalid data' do
      it 'does not save the account' do
        expect {
          post :create, params: { my_target_account: attributes_for(:invalid_my_target_account) }, format: :js
        }.to_not change(MyTarget::Account, :count)
      end

      it 'returns bad status' do
        post :create, params: { my_target_account: attributes_for(:invalid_my_target_account) }, format: :js
        expect(response).to_not be_success
      end

      it 'returns errors array' do
        post :create, params: { my_target_account: attributes_for(:invalid_my_target_account) }, format: :js
        errors = JSON.parse(response.body)
        expect(errors).to match_array ["Login can't be blank", "Password can't be blank",
                                       "Name can't be blank", "Link can't be blank",
                                       "Login is invalid", "Password is too short (minimum is 6 characters)"]
      end
    end
  end


  describe 'PATCH #update' do
    context 'with valid data' do
      it 'assigns account to @account' do
        patch :update, params: { id: account, my_target_account: attributes_for(:my_target_account) }, format: :js
        expect(assigns(:account)).to eq account
      end

      it 'changes event attributes' do
        patch :update, params: { id: account, my_target_account: {name: 'New name'} }, format: :js
        account.reload
        expect(account.name).to eq 'New name'
      end

      it 'publishes account to /accounts' do
        expect(ActionCablePublisher).to receive(:publish_account).with('update', account.id)
        patch :update, params: { id: account, my_target_account: attributes_for(:my_target_account) }, format: :js
      end
    end

    context 'with invalid data' do
      before { patch :update, params: { id: account, my_target_account: attributes_for(:invalid_my_target_account) }, format: :js }

      it 'assigns account to @account' do
        expect(assigns(:account)).to eq account
      end

      it 'not changes event attributes' do
        account.reload
        %i(name login password link).each do |attr|
          expect(account[attr]).to_not be_blank
        end
      end

      it 'returns errors array' do
        errors = JSON.parse(response.body)
        expect(errors).to match_array ["Login can't be blank", "Password can't be blank",
                                       "Name can't be blank", "Link can't be blank",
                                       "Login is invalid", "Password is too short (minimum is 6 characters)"]
      end
    end
  end


  describe 'PATCH #synchronize' do
    it 'assigns the requested account to @account' do
      patch :synchronize, params: { id: account }, format: :js
      expect(assigns(:account)).to eq account
    end

    it 'calls SynchronizeAccountJob' do
      expect(SynchronizeAccountJob).to receive(:perform_later).with(account.id)
      patch :synchronize, params: { id: account }, format: :js
    end
  end


  describe 'DELETE #destroy' do
    it 'deletes account' do
      expect{
        delete :destroy, params: { id: account }, format: :js
      }.to change(MyTarget::Account, :count).by(-1)
    end

    it 'publishes account to /accounts' do
      expect(ActionCablePublisher).to receive(:publish_account).with('delete', account.id)
      delete :destroy, params: { id: account }, format: :js
    end
  end

end
