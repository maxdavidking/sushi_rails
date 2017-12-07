require 'rails_helper'

RSpec.describe User, type: :model do
  subject{described_class.new(name: "Max King", organization: "IIT", uid: "01101001111", provider: "Google")}

  describe 'validations' do
    describe 'validate name field' do
      it 'must be present' do
        expect(subject).to be_valid(:name)

        subject.name = nil
        expect(subject).to_not be_valid(:name)
      end
    end
    describe 'validate organization field' do
      it 'must be present' do
        expect(subject).to be_valid(:organization)

        subject.organization = nil
        expect(subject).to_not be_valid(:organization)
      end
    end
    describe 'validate provider field' do
      it 'must be present' do
        expect(subject).to be_valid(:provider)

        subject.provider = nil
        expect(subject).to_not be_valid(:provider)
      end
    end
    describe 'validate uid field' do
      it 'must be present' do
        expect(subject).to be_valid(:uid)

        subject.uid = nil
        expect(subject).to_not be_valid(:uid)
      end
    end
  end
end
