class LossLimitsController < BaseController
  def update
    submit_form(LossLimitsForm.new(current_player), :ok)
  end
end
