class TwentyFourSevenOffice::Company
  TYPE = 'Supplier'.freeze

  def initialize(player)
    @player = player
  end

  def id
    @player.twenty_four_seven_office_id
  end

  def name
    @player.full_name
  end

  def external_id
    @player.id
  end

  def bank_account_number
    @player.bank_account_number
  end

  def to_hash
    {
      'Company' => {
        'Id' => id,
        'Name' => name,
        'Type' => TYPE,
        'ExternalId' => external_id,
        'BankAccountNo' => bank_account_number
      }
    }
  end
end
