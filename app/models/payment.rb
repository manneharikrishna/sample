class Payment < Transaction
  validates :entry, presence: true, uniqueness: true
  validates :amount, numericality: { less_than: 0 }
end
