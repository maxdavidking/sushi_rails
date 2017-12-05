require 'rails_helper'

RSpec.describe Sushi, type: :model do

  subject{described_class.new(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "")}

  describe 'validations' do
    describe 'validate name field' do
      it 'must be present' do
        expect(subject).to be_valid(:name)

        subject.name = nil
        expect(subject).to_not be_valid(:name)
      end
    end
    describe 'validate endpoint field' do
      it 'must be present' do
        expect(subject).to be_valid(:endpoint)

        subject.endpoint = nil
        expect(subject).to_not be_valid(:endpoint)
      end
    end
    describe 'validate cust_id field' do
      it 'must be present' do
        expect(subject).to be_valid(:cust_id)

        subject.cust_id = nil
        expect(subject).to_not be_valid(:cust_id)
      end
    end
    describe 'validate req_id field' do
      it 'must be present' do
        expect(subject).to be_valid(:req_id)

        subject.req_id = nil
        expect(subject).to_not be_valid(:req_id)
      end
    end
    describe 'validate report_start field' do
      it 'must be present' do
        expect(subject).to be_valid(:report_start)

        subject.report_start = nil
        expect(subject).to_not be_valid(:report_start)
      end
    end
    describe 'validate report_end field' do
      it 'must be present' do
        expect(subject).to be_valid(:report_end)

        subject.report_end = nil
        expect(subject).to_not be_valid(:report_end)
      end
    end
  end
end
