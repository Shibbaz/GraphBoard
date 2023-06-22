module Storage
    class Upload
        def self.call(bucket:, key:, file:, storage: Rails.configuration.s3)
          raise FileInvalidTypeError if File.extname(file.path) != '.mov'
          config = {
            key:,
            bucket:
          }
          storage.put_object(
            key: config[:key],
            body: file.read,
            bucket: config[:bucket]
          )
        end
    end
end