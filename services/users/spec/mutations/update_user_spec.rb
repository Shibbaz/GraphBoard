RSpec.describe Mutations::UpdateUser, type: :request do
    let(:user) { create(:user) }

    describe 'Mutation Success' do
        it 'expects to update user successfully' do
            mutation = Mutations::UpdateUser.new(object: nil, field: nil, context: {
                current_user: user
            }).resolve(
                attributes: {
                    name: "kamil",
                    surname: "Mosciszko",
                    birthday: "04/09/1997",
                    phone: 667089180,
                    description: Faker::String.random(length: 50),
                    technologies: [{
                        name: "Python",
                        experience: "2 years"
                    }]
                }
            )
            user.reload
            expect(user.name).to eq("kamil")
            expect(user.surname).to eq("Mosciszko")
            expect(user.birthday).to eq("04/09/1997")
        end

        it 'expects to fail deleting user' do      
            expect{Mutations::UpdateUser.new(object: nil, field: nil, context: {
                current_user: nil
            }).resolve(
                attributes: {}
            )}.to raise_error(GraphQL::ExecutionError)
        end
    end
end