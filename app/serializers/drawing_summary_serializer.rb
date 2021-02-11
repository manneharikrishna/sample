class DrawingSummarySerializer < ActiveModel::Serializer
  attribute :weekly_tickets_count
  attribute :subscription_tickets_count
  attribute :drawing_revenue
end
