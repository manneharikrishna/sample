class Admin::DrawingStatisticsSerializer < ActiveModel::Serializer
  has_many :revenue_statistics, key: :revenue
  has_many :tickets_statistics, key: :tickets
  has_many :spending_statistics, key: :spending
  has_many :payout_statistics, key: :payout
end
