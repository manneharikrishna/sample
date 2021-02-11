Cloudinary.config do |config|
  config.cloud_name = ENV.fetch('CLOUDINARY_CLOUD_NAME')
  config.api_key = ENV.fetch('CLOUDINARY_API_KEY')
  config.api_secret = ENV.fetch('CLOUDINARY_API_SECRET')
  config.private_cdn = ENV['CLOUDINARY_PRIVATE_CDN']
  config.secure_distribution = ENV['CLOUDINARY_SECURE_DISTRIBUTION']
  config.upload_prefix = ENV['CLOUDINARY_UPLOAD_PREFIX']
  config.secure = true
end
