require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:sushis) }
  it { should have_many(:data) }
  it { should have_many(:users) }
end
