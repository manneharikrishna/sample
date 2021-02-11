class Withdrawal < Transaction
  store_accessor :data, :bank_account_number

  validates :amount, numericality: { less_than: 0 }
end
