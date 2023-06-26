require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { 
      create(:user)
    }
    it 'expects creation to be successful' do
      expect(create(:user)).to be_valid
    end

    it 'expects argument email not to be blank' do
      expect{create(:user, email: "")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank, Email is invalid"
      )
    end

    it 'expects argument mail to be validated as email format' do
      expect(user.email).to match(URI::MailTo::EMAIL_REGEXP)
    end

    it 'expects argument mail not to be validated as email format' do
      expect{create(:user, email: "not")}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email is invalid")
    end

    it 'expects argument name not to be validated' do
      expect{create(:user, name: "m")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Name is too short (minimum is 3 characters)"
      )
    end

    it 'expects argument name to be validated as string' do
      expect(user.email.class).to be(String)
    end

    it 'expects argument surname to be validated as string' do
      expect(user.surname.class).to be(String)
    end

    it 'expects argument surname not to be validated' do
      expect{create(:user, surname: "m")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Surname is too short (minimum is 3 characters)"
      )
    end

    it 'expects argument phone to be validated as integer' do
      expect(user.phone.class).to be(Integer)
    end

    it 'expects argument phone not to be validated' do
      expect{create(:user, phone: "m")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Phone is not a number"
      )
    end

    it 'expects argument description to be validated as string' do
      expect(user.description.class).to be(String)
    end

    it 'expects argument description not to be validated' do
      expect{create(:user, description: "m")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Description is too short (minimum is 50 characters)"
      )
    end

    it 'expects argument technologies to be validated as array' do
      expect(user[:technologies].class).to be(Array)
    end

    it 'expects argument technologies not to be validated' do
      user = create(:user, technologies: [])
      expect(user[:technologies].size).to eq(0)
    end

    it 'expects argument birthday to be validated as ActiveSupport::TimeWithZone' do
      expect(user.birthday.class).to be(ActiveSupport::TimeWithZone)
    end

    it 'expects argument birthday not to be validated' do
      expect{create(:user, birthday: "m")}.to raise_error(
        ActiveRecord::RecordInvalid, "Validation failed: Birthday can't be blank"
      )
    end
  end
end
