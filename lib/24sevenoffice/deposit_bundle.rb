class TwentyFourSevenOffice::DepositBundle < TwentyFourSevenOffice::TransactionBundle
  ENTRY_TYPE = 5

  def sort
    ENTRY_TYPE
  end

  def name
    "#{formatted_date} - deposit"
  end
end
