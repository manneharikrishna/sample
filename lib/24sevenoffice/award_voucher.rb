class TwentyFourSevenOffice::AwardVoucher < TwentyFourSevenOffice::TransactionVoucher
  DEBIT_ACCOUNT_ID = 4000
  CREDIT_ACCOUNT_ID = 2400

  def account_ids
    [DEBIT_ACCOUNT_ID, CREDIT_ACCOUNT_ID]
  end
end
