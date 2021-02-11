class TwentyFourSevenOffice::TransactionBundle
  def initialize(transactions)
    @transactions = transactions
  end

  def year_id
    date.year
  end

  def sort
    raise NotImplementedError
  end

  def name
    raise NotImplementedError
  end

  def vouchers
    @transactions.map { |t| voucher_class(t).new(self, t) }
  end

  def voucher_class(transaction)
    TwentyFourSevenOffice.const_get("#{transaction.class}Voucher")
  end

  private

  def date
    @transactions.first.created_at.to_date
  end

  def formatted_date
    date.strftime('%d.%m.%y')
  end
end
