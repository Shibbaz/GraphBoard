# frozen_string_literal: true
credentials = Rails.application.credentials
Storage::Build.call(
  endpoint: credentials[:S3_Endpoint],
  access_key_id: credentials[:S3_User_Name],
  secret_access_key: credentials[:S3_SECRET_KEY]
)