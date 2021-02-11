class DrawingTransition < ActiveRecord::Base
  belongs_to :drawing, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = drawing.transitions.order(:sort_key).last
    last_transition&.update_column(:most_recent, true)
  end
end
