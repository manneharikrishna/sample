class TwentyFourSevenOffice::PaymentVoucher < TwentyFourSevenOffice::TransactionVoucher
  CREDIT_ACCOUNT_ID = 2400
  GROSS_REVENUE_ACCOUNT_ID = 3000

  def account_ids
    [CREDIT_ACCOUNT_ID, GROSS_REVENUE_ACCOUNT_ID]
  end
end
