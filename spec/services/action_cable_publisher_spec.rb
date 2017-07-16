require 'rails_helper'

RSpec.describe ActionCablePublisher do

  describe 'publish_account method' do
    let!(:account) { create(:my_target_account) }

    context 'with update action' do
      it 'publishes account to /accounts' do
        expect(ActionCable.server).to receive(:broadcast)
                                      .with('accounts', { id: account.id, action: 'update', account: anything })
        ActionCablePublisher.publish_account 'update', account.id
      end
    end

    context 'with create action' do
      it 'publishes account to /accounts' do
        expect(ActionCable.server).to receive(:broadcast)
                                      .with('accounts', { id: account.id, action: 'create', account: anything })
        ActionCablePublisher.publish_account 'create', account.id
      end
    end

    context 'with delete action' do
      it 'publishes account to /accounts' do
        expect(ActionCable.server).to receive(:broadcast)
                                      .with('accounts', { id: account.id, action: 'delete', account: nil })
        ActionCablePublisher.publish_account 'delete', account.id
      end
    end
  end
end
