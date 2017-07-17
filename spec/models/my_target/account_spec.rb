require 'rails_helper'

RSpec.describe MyTarget::Account, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :login }
  it { should validate_presence_of :password }
  it { should validate_presence_of :link }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:pads).dependent(:destroy) }

  describe 'set_status method' do
    let!(:account) { create(:my_target_account) }

    it 'should change account status' do
      expect(account.status).to eq 'not synchronized'
      account.set_status 'synchronization in progress'
      expect(account.status).to eq 'synchronization in progress'
    end

    it 'should publish account to channel' do
      expect(ActionCablePublisher).to receive(:publish_account).with('update', account.id)
      account.set_status 'synchronization in progress'
    end
  end
end
