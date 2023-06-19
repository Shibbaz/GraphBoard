namespace :graphql do
    namespace :federation do
      task :dump do
        File.write("schema.graphql", UsersSchema.federation_sdl)
      end
    end
end