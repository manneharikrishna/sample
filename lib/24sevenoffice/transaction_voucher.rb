class TwentyFourSevenOffice::TransactionVoucher
  TAX_NUMBER = 0

  def initialize(bundle, transaction)
    @bundle = bundle
    @transaction = transaction
    @player = transaction.player
  end

  def customer_id
    @player.twenty_four_seven_office_id
  end

  def account_ids
    raise NotImplementedError
  end

  def date
    @transaction.created_at.to_date.iso8601
  end

  def amount
    @transaction.amount.abs
  end

  def currency_id
    CURRENCY
  end

  def tax_number
    TAX_NUMBER
  end

  def comment
    @bundle.name
  end

  def bank_account_number
    @player.bank_account_number
  end
end
