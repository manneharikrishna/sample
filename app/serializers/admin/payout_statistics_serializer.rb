class Admin::PayoutStatisticsSerializer < ActiveModel::Serializer
  attribute :total_prize_payout
  attribute :total_prize_payout_ratio

  has_many :prizes

  def total_prize_payout_ratio
    format('%.1f', object.total_prize_payout_ratio)
  end
end
