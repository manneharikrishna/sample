class Admin::LicenseSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :lottery_type
  attribute :min_duration
  attribute :max_duration
  attribute :max_tickets_count
  attribute :max_total_revenue
  attribute :min_payback_ratio
  attribute :max_payback_ratio
end
