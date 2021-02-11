class Winning < ApplicationRecord
  belongs_to :drawing
  belongs_to :ticket, class_name: 'Ticket'

  validates :drawing, presence: true
  validates :ticket, presence: true

  def winner
    ticket.entry.player
  end
end
