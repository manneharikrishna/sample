class Admin::WithdrawalSerializer < WithdrawalSerializer
  attribute :id
  attribute :bank_account_number
  attribute :player_name

  def player_name
    object.player.full_name
  end
end
