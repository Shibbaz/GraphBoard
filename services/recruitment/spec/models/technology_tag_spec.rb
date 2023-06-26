require "rails_helper"

RSpec.describe TechnologyTag, type: :model do
  describe "validations" do
    let(:technology_tag) {
      create(:technology_tag)
    }

    it "expects creation to be successful" do
      expect(technology_tag).to be_valid
    end

    it "expects argument name not to be blank" do
      expect { create(:technology_tag, name: "") }.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Name is too short (minimum is 1 character), Name can't be blank"
      )
    end
  end
end
