class TwentyFourSevenOffice::WithdrawalVoucher < TwentyFourSevenOffice::TransactionVoucher
  CREDIT_ACCOUNT_ID = 2400

  def account_ids
    [CREDIT_ACCOUNT_ID, CREDIT_ACCOUNT_ID]
  end

  def comment
    I18n.t('24sevenoffice.withdrawal.comment', application: LOCAL_APP_NAME)
  end

  def bank_account_number
    @transaction.bank_account_number
  end
end
