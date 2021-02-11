class TicketAutoreveal < ApplicationRecord
  TICKET_TYPES = %w[weekly subscription].freeze

  belongs_to :ticket

  scope :weekly, -> { where(ticket_type: 'weekly') }
  scope :subscription, -> { where(ticket_type: 'subscription') }
end
