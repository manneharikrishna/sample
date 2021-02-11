class Regulation::DrawingStatisticsSerializer < Admin::DrawingStatisticsSerializer
  class RevenueStatisticsSerializer < Admin::RevenueStatisticsSerializer; end
  class TicketsStatisticsSerializer < Admin::TicketsStatisticsSerializer; end
  class SpendingStatisticsSerializer < Admin::SpendingStatisticsSerializer; end

  class PayoutStatisticsSerializer < Admin::PayoutStatisticsSerializer
    class PrizeStatisticsSerializer < Admin::PrizeStatisticsSerializer; end
  end
end
