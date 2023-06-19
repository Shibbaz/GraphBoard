require 'rails_helper'

RSpec.describe Concepts::Users::Repository, type: :request do
    subject(:repository) { Concepts::Users::Repository.new }    
    let(:informations) do
        {
            name: Faker::Name.name,
            surname: Faker::Name.name,
            birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
            phone: Faker::Number.number(digits: 9),   
            description: "LoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsumLoremIpsum",
            technologies: [{
                name: "Ruby",
                experience: "2 years"
            }] 
        }
    end

    let(:auth_provider) do
        {
            email: Faker::Internet.email,
            password: Faker::Internet.password
        }
    end

    describe 'method create' do
        it 'expects to create user successfully' do
            event = repository.create(informations: informations, auth_provider: auth_provider)
            expect(event).to(have_published(UserWasCreated))
        end

        it 'expects not to create user' do
            expect{ 
                repository.create(
                    informations: nil,
                    auth_provider: nil
                ) }.to raise_error(
                    ActiveRecord::RecordInvalid
                )
        end
    end

    describe 'method delete' do
        let(:user) { create(:user) }

        it 'expects to delete user successfully' do
            event = repository.delete(
                current_user: user
            )
            expect(event).to(have_published(UserWasDeleted))
            expect{ user.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'expects to delete non-existing user' do
            expect{ 
                repository.delete(
                    current_user: nil
                ) }.to raise_error(
                    ActiveRecord::RecordNotFound
                )
        end
    end

    describe 'method update' do
        let(:user) { create(:user) }

        it 'expects to update user successfully' do
            event = repository.update(
                args: informations,
                current_user: user 
            )            
            expect(event).to(have_published(UserWasUpdated))
            user.reload
            expect(user.name).to eq(informations[:name])
            expect(user.surname).to eq(informations[:surname])
            expect(user.birthday).to eq(informations[:birthday])
            expect(user.phone).to eq(informations[:phone])
            expect(user.description).to eq(informations[:description])

        end

        it 'expects to update non-existing user' do
            expect{ 
                repository.update(
                    current_user: nil,
                    args: {}
                ) }.to raise_error(
                    ActiveRecord::RecordNotFound
                )
        end
    end
end
