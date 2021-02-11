class GenerateWeeklyLotteryUrl
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    MergeUrlParameters.new(url, lid: @drawing.id).call
  end

  private

  def url
    ENV['WEEKLY_LOTTERY_REDIRECT_URL']
  end
end
