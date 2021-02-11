class LogRepository
  include Elasticsearch::Persistence::Repository

  client ELASTICSEARCH_CLIENT

  index_name Rails.env

  document_type :log_entry
end
