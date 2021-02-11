class Deposit < Transaction
  attr_accessor :redirect_url

  store_accessor :data, :nets_payment_id

  after_initialize :set_status, if: :new_record?

  def completed?
    status == 'completed'
  end

  private

  def set_status
    self.status = 'pending'
  end
end
