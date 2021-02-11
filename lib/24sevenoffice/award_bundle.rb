class TwentyFourSevenOffice::AwardBundle < TwentyFourSevenOffice::TransactionBundle
  ENTRY_TYPE = 8

  def sort
    ENTRY_TYPE
  end

  def name
    "#{formatted_date} - award"
  end
end
