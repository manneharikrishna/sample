class TwentyFourSevenOffice::DepositVoucher < TwentyFourSevenOffice::TransactionVoucher
  BANK_DEPOSITS_ID = 1920
  CREDIT_ACCOUNT_ID = 2400

  def account_ids
    [BANK_DEPOSITS_ID, CREDIT_ACCOUNT_ID]
  end
end
