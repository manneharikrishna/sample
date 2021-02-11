class Admin::TicketsStatisticsSerializer < ActiveModel::Serializer
  attribute :players_count
  attribute :sold_tickets_count
  attribute :winning_tickets_count
end
