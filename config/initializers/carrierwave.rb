CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    provider: 'AWS',
    region: 'us-west-1',
    host: "#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com",
    endpoint: "https://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com"
  }

  config.fog_directory = ''
  config.fog_public = true
end
