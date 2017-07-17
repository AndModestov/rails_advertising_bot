require 'rails_helper'

RSpec.describe MyTarget::Pad, type: :model do
  it { should have_many(:addunits).dependent(:destroy) }
  it { should belong_to :account }
  it { should validate_presence_of :name }
  it { should validate_presence_of :service_id }
  it { should validate_presence_of :account_id }
end
