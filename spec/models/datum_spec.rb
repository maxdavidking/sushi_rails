require "rails_helper"

RSpec.describe Datum, type: :model do
  it { should belong_to(:organization) }
end
