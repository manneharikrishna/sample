class TwentyFourSevenOffice::Error < StandardError
  def initialize(response)
    super(response.body.dig(:fault, :faultstring))
  end
end
