require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it 'expects to pass when all attributes are present' do
      video = create(:video)
      expect(video).to be_valid
    end

    it 'expects to fail when name is not present' do
      expect{create(:video, name: nil)}.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Name can't be blank"
      )
    end

    it 'expects to fail when description is not present' do
      expect{create(:video, description: nil)}.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Description can't be blank"
      )
    end

    it 'expects to fail when type is not present' do
      expect{create(:video, type: nil)}.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Type can't be blank"
      )
    end

    it 'expects to fail when author is not present' do
      expect{create(:video, author: nil)}.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Author can't be blank"
      )
    end

    it 'expects to fail when rules is not present' do
      expect{create(:video, rules: nil)}.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Rules can't be blank"
      )
    end      
  end
end
