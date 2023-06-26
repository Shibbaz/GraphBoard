RSpec.describe Mutations::DeleteUser, type: :request do
    let(:user) { create(:user) }

    describe 'Mutation Success' do
        it 'expects to delete user successfully' do
            mutation = Mutations::DeleteUser.new(object: nil, field: nil, context: {
                current_user: user
            }).resolve
            expect(mutation[:status]).to eq(200)
        end

        it 'expects to fail deleting user' do        
            expect(Mutations::DeleteUser.new(object: nil, field: nil, context: {
                current_user: nil
            }).resolve).to eq(GraphQL::ExecutionError.new('Authentication Error'))
        end
    end
end