require 'rails_helper'

RSpec.describe User, type: :model do
  subject{described_class.new(name: "Max King", organization: "IIT")}

  describe 'validations' do
    describe 'validate name field' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.name = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
