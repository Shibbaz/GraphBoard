require 'rails_helper'

RSpec.describe Resolvers::UserSearch, type: :graphql do
  describe "#resolve with no params" do

    let(:user) { create(:user) }

    let(:context) do
      {
        current_user: user
      }
    end

    let(:query) do  
      <<-GQL
          query Users {
              users {
                birthday
                description
                email
                name
                phone
                surname
                technologies
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = UsersSchema.execute(query, context: context, variables: {}).to_h
      resolverUsers = resolver["data"]["users"].first
      
      expect(resolverUsers["birthday"]).to eq(user.birthday.strftime("%d/%m/%Y"))
      expect(resolverUsers["description"]).to eq(user.description)
      expect(resolverUsers["email"]).to eq(user.email)
      expect(resolverUsers["name"]).to eq(user.name)
      expect(resolverUsers["phone"]).to eq(user.phone)
      expect(resolverUsers["surname"]).to eq(user.surname)
      expect(resolverUsers["technologies"]).to eq(user.technologies)
    end

    it "does not execute query" do
      resolver = UsersSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param name and surname" do
    let(:user){ create(:user)}

    let(:context) do
      {
        current_user: user
      }
    end

    let(:query) do  
      <<-GQL
          query Users($name: String, $surname: String) {
              users(name: $name, surname: $surname) {
                birthday
                description
                email
                name
                phone
                surname
                technologies
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = UsersSchema.execute(query, context: context, variables: {
        name: user.name,
        surname: user.surname
      }).to_h
      resolverUsers = resolver["data"]["users"].first
      
      expect(resolverUsers["birthday"]).to eq(user.birthday.strftime("%d/%m/%Y"))
      expect(resolverUsers["description"]).to eq(user.description)
      expect(resolverUsers["email"]).to eq(user.email)
      expect(resolverUsers["name"]).to eq(user.name)
      expect(resolverUsers["phone"]).to eq(user.phone)
      expect(resolverUsers["surname"]).to eq(user.surname)
      expect(resolverUsers["technologies"]).to eq(user.technologies)
    end

    it "does not execute query" do
      resolver = UsersSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param technologies" do
    let(:user){ create(:user)}

    let(:context) do
      {
        current_user: user
      }
    end    
    
    let(:query) do  
      <<-GQL
          query Users($technologies: [String!]) {
              users(technologies: $technologies) {
                birthday
                description
                email
                name
                phone
                surname
                technologies
              }
          }
      GQL
    end
    
    it "executes query" do
      resolver = UsersSchema.execute(query, context: context, variables: {
        technologies: user.technologies.pluck("name")
      }).to_h
      resolverUsers = resolver["data"]["users"].first
      
      expect(resolverUsers["birthday"]).to eq(user.birthday.strftime("%d/%m/%Y"))
      expect(resolverUsers["description"]).to eq(user.description)
      expect(resolverUsers["email"]).to eq(user.email)
      expect(resolverUsers["name"]).to eq(user.name)
      expect(resolverUsers["phone"]).to eq(user.phone)
      expect(resolverUsers["surname"]).to eq(user.surname)
      expect(resolverUsers["technologies"]).to eq(user.technologies)
    end

    it "does not execute query" do
      resolver = UsersSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end
end