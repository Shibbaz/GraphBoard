require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    let(:offer) { 
      create(:offer)
    }
    it 'expects creation to be successful' do
      expect(offer).to be_valid
    end

    it 'expects argument name not to be blank' do
      expect{create(:offer, name: "")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank, Name is too short (minimum is 8 characters)"
      )
    end

    it 'expects argument name not to have minimum length 8 characters' do
      expect{create(:offer, name: "")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank, Name is too short (minimum is 8 characters)"
      )
    end

    it 'expects argument requirements to have at least one element' do
      expect{create(:offer, requirements: [])}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Requirements can't be blank, Requirements should have at least 1 requirement defined"
      )
    end

    it 'expects argument tags to have at least one element' do
      expect{create(:offer, tags: [])}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Tags can't be blank, Tags should have at least 1 requirement defined"
      )
    end

    it 'expects argument author to have at least one element' do
      expect{create(:offer, author: nil)}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Author can't be blank"
      )
    end

    it 'expects argument contact_details to have at least one element' do
      expect{create(:offer, contact_details: nil)}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Contact details can't be blank, Contact details should have at least contact details"
      )
    end
  end
end
