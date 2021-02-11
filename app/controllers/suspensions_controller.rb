class SuspensionsController < BaseController
  def create
    submit_form(SuspensionForm.new(current_player))
  end
end
