require 'rails_helper'

RSpec.describe Resolvers::OfferSearch, type: :graphql do
  describe "#resolve with no params" do

    let(:current_user_id) { SecureRandom.uuid }

    let(:context) do
      {
        current_user_id: current_user_id
      }
    end

    before do create(:offer) end

    let(:query) do  
      <<-GQL
          query Offers {
              offers {
                name
                description
                requirements
                tags
                contactDetails
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = RecruitmentsSchema.execute(query, context: context, variables: {}).to_h
      resolverOffers = resolver["data"]["offers"]
      expect(resolverOffers.first["name"]).to eq(Offer.first.name)
      expect(resolverOffers.first["description"]).to eq(Offer.first.description)
      expect(resolverOffers.first["tags"]).to eq(Offer.first.tags)
      expect(resolverOffers.first["contactDetails"]).to eq(Offer.first.contact_details)
    end

    it "does not execute query" do
      resolver = RecruitmentsSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param name" do
    let(:offer){ create(:offer)}

    let(:context) do
      {
        current_user_id: SecureRandom.uuid
      }
    end

    let(:query) do  
      <<-GQL
          query Offers($name: String) {
              offers(name: $name) {
                name
                description
                requirements
                tags
                contactDetails
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = RecruitmentsSchema.execute(query, context: context, variables: {
        name: offer.name,
      }).to_h
      resolverOffers = resolver["data"]["offers"]
      expect(resolverOffers.first["name"]).to eq(Offer.first.name)
      expect(resolverOffers.first["description"]).to eq(Offer.first.description)
      expect(resolverOffers.first["tags"]).to eq(Offer.first.tags)
      expect(resolverOffers.first["contactDetails"]).to eq(Offer.first.contact_details)
    end

    it "does not execute query" do
      resolver = RecruitmentsSchema.execute(query, context: {
        current_user_id: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param technologies" do
    let(:offer){ create_list(:offer, 10)}

    let(:context) do
      {
        current_user_id: SecureRandom.uuid
      }
    end    
    
    let(:query) do  
      <<-GQL
          query Offers($tags: [ID!]) {
              offers(tags: $tags) {
                name
                description
                requirements
                tags
                contactDetails
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = RecruitmentsSchema.execute(query, context: context, variables: {
        tags: offer[0].tags
      }).to_h
      resolverOffers = resolver["data"]["offers"]
      expect(resolverOffers.size).to eq(1)
    end

    it "does not execute query" do
      resolver = RecruitmentsSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end
end