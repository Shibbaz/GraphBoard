RSpec.describe Mutations::UpdateOffer, type: :request do
  let(:user_id) {
    SecureRandom.uuid
  }
  let(:offer) { create(:offer, author: user_id) }
  let(:informations) {
    {
      name: "Typescript developer"
    }
  }
  describe "Mutation Success" do
    it "expects to update offer successfully" do
      mutation = Mutations::UpdateOffer.new(object: nil, field: nil, context: {
        current_user_id: user_id
      }).resolve(offer_id: offer.id, informations: informations)
      expect(mutation[:status]).to eq(200)
      offer.reload
      expect(offer.name).to eq("Typescript developer")
    end

    it "expects to fail update offer" do
      expect {
        Mutations::UpdateOffer.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(offer_id: offer.id, informations: {})
      }.to raise_error(GraphQL::ExecutionError, "Authentication Error")
    end
  end
end
