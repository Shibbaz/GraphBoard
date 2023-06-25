module Concepts
    module Tags
        class Repository
            attr_accessor :adapter

            def initialize(adapter: TechnologyTag)
                @adapter = adapter
            end

            def create(informations:)
              raise ArgumentError.new "Please, pass params. Params not found" if informations.nil?
              ActiveRecord::Base.transaction do
                tag_id = SecureRandom.uuid
                Rails.configuration.event_store.publish(
                  TagWasCreated.new(
                    data: {
                      tag_id: tag_id,
                      adapter: @adapter,
                      informations: informations.to_h
                    }
                  ),
                  stream_name: "Tags-#{tag_id}"
                )
              end
            end

            def update(tag_id:, informations:)
              tag = @adapter.find_by(id: tag_id)
              raise ActiveRecord::RecordNotFound unless tag
              ActiveRecord::Base.transaction do
                Rails.configuration.event_store.publish(
                  TagWasUpdated.new(data:{
                    tag: tag,
                    informations: informations.to_h
                  }),
                  stream_name: "Tags-#{tag_id}"
                )
              end
            end

            def delete(tag_id:)
                tag = @adapter.find_by(id: tag_id)
                raise ActiveRecord::RecordNotFound unless tag
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      TagWasDeleted.new(data:{
                        tag: tag
                      }),
                      stream_name: "Tag-#{tag_id}"
                    )
                end
            end
        end
    end
end

