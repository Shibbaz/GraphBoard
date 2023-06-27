module Storage
  class Delete
    def self.call(bucket:, key:, storage: Rails.configuration.s3)
      raise ::FileNoKeyError.new if key.eql?(nil)
      config = {
        key:,
        bucket:
      }

      storage.delete_object({
        bucket: config[:bucket],
        key: config[:key]
      })
    end
  end
end
