region = ENV.fetch('AWS_SES_REGION')
access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID')
secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY')

credentials = Aws::Credentials.new(access_key_id, secret_access_key)

Aws::Rails.add_action_mailer_delivery_method(
  :aws_sdk,
  region: region,
  credentials: credentials
)
