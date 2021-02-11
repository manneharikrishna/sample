class Transaction < ApplicationRecord
  STATUSES = %w[pending cancelled completed failed].freeze

  belongs_to :player
  belongs_to :entry
  belongs_to :subscription

  scope :completed, -> { where(status: 'completed') }
  scope :since, ->(time) { where('created_at >= ?', time) }

  validates :player, presence: true

  def self.from_date(date)
    where(created_at: (date.beginning_of_day..date.end_of_day))
  end
end
