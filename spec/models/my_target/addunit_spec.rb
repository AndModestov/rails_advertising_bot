require 'rails_helper'

RSpec.describe MyTarget::Addunit, type: :model do
  it { should belong_to :pad }
  it { should validate_presence_of :name }
  it { should validate_presence_of :service_id }
  it { should validate_presence_of :pad_id }
  it { should validate_presence_of :format }
end
