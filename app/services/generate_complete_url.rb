class GenerateCompleteUrl
  def initialize(url, deposit)
    @url = url
    @deposit = deposit
  end

  def call
    MergeUrlParameters.new(url, deposit_id: deposit.id).call
  end

  private

  attr_reader :url
  attr_reader :deposit
end
