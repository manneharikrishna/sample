class Admin::PrizeStatisticsSerializer < ActiveModel::Serializer
  attribute :name
  attribute :prize_payout
  attribute :prize_payout_ratio

  def prize_payout_ratio
    format('%.1f', object.prize_payout_ratio)
  end
end
