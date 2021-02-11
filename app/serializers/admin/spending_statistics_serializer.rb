class Admin::SpendingStatisticsSerializer < ActiveModel::Serializer
  attribute :lowest_spending
  attribute :highest_spending
  attribute :average_spending
end
