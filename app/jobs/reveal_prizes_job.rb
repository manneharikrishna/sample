class RevealPrizesJob < ApplicationJob
  def perform(drawing)
    RevealPrizes.new(drawing).call
  end
end
