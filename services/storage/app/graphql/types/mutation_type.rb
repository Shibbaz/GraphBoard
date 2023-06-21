module Types
  class MutationType < Types::BaseObject
    field :update_video, mutation: Mutations::UpdateVideo
    field :create_video, mutation: Mutations::CreateVideo
    field :delete_video, mutation: Mutations::DeleteVideo
  end
end
