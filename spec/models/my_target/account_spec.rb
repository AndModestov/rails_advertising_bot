require 'rails_helper'

RSpec.describe MyTarget::Account, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :login }
  it { should validate_presence_of :password }
  it { should validate_presence_of :link }
  it { should validate_length_of(:password).is_at_least(6) }
end
