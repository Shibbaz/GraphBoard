module Storage
  class Build
      def self.call(endpoint:, access_key_id:, secret_access_key:)
        Aws.config.update(
          endpoint:,
          access_key_id:,
          secret_access_key:,
          force_path_style: true,
          region: 'us-east-1'
        )

        Rails.configuration.s3 = if ['test'].include? ENV['RAILS_ENV']
                                  Aws::S3::Client.new(stub_responses: true)
                                else
                                  Aws::S3::Client.new
                                end
      end
  end
end