require 'rails_helper'

RSpec.describe Sushi, type: :model do

  subject{described_class.new(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "")}

  describe 'validations' do
    describe 'validate name field' do
      it 'must be present' do
        expect(subject).to be_valid

        subject.name = nil
        expect(subject).to_not be_valid(:name)
      end
    end
  end
end
