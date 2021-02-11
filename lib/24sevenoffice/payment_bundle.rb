class TwentyFourSevenOffice::PaymentBundle < TwentyFourSevenOffice::TransactionBundle
  ENTRY_TYPE = 2

  def sort
    ENTRY_TYPE
  end

  def name
    "#{formatted_date} - gross revenue"
  end
end
