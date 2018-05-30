require 'rails_helper'

RSpec.describe Sushi, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:endpoint) }
  it { should validate_presence_of(:cust_id) }
  it { should validate_presence_of(:report_start) }
  it { should validate_presence_of(:report_end) }
  it { should validate_uniqueness_of(:name).scoped_to(:organization_id) }
end
