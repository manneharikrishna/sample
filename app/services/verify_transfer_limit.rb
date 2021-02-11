class VerifyTransferLimit
  delegate :transfer_limit, to: Limits

  def initialize(amount)
    @amount = amount.to_d
  end

  def call
    if amount < transfer_limit
      raise ResponseError, :forbidden
    end
  end

  private

  attr_reader :amount
end
