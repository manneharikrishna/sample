require 'faraday_middleware/aws_sigv4'

elasticsearch_url = ENV.fetch('ELASTICSEARCH_URL') { 'localhost:9200' }

ELASTICSEARCH_CLIENT =
  if elasticsearch_url.end_with?('es.amazonaws.com')
    region = ENV.fetch('AWS_ES_REGION')
    access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID')
    secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY')

    credentials = Aws::Credentials.new(access_key_id, secret_access_key)

    Elasticsearch::Client.new(url: elasticsearch_url) do |f|
      f.request :aws_sigv4, service: 'es', region: region, credentials: credentials
    end
  else
    Elasticsearch::Client.new(url: elasticsearch_url)
  end
