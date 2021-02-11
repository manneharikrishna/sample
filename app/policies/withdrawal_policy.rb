WithdrawalPolicy = Struct.new(:player, :withdrawal) do
  def create?
    player.bank_account_number.present?
  end
end
