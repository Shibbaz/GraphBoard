RSpec.describe Mutations::DeleteOffer, type: :request do
  let(:user_id) {
    SecureRandom.uuid
  }
  let(:offer) { create(:offer, author: user_id) }

  describe "Mutation Success" do
    it "expects to delete offer successfully" do
      mutation = Mutations::DeleteOffer.new(object: nil, field: nil, context: {
        current_user_id: user_id
      }).resolve(offer_id: offer.id)
      expect(mutation[:status]).to eq(200)
    end

    it "expects to fail deleting offer" do
      expect(
        Mutations::DeleteOffer.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(offer_id: offer.id)
      ).to eq(GraphQL::ExecutionError.new("Authentication Error"))
    end
  end
end
