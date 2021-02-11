class TwentyFourSevenOffice::WithdrawalBundle < TwentyFourSevenOffice::TransactionBundle
  ENTRY_TYPE = 1

  def sort
    ENTRY_TYPE
  end

  def name
    "#{formatted_date} - outgoing payment"
  end
end
