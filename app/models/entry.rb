class Entry < ApplicationRecord
  STATUSES = %w[pending approved rejected].freeze

  belongs_to :drawing
  belongs_to :player
  belongs_to :photo

  has_one :payment

  has_many :tickets
  has_many :winnings, through: :tickets
  has_many :prizes, through: :tickets

  has_event :reveal

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }

  scope :with_photo, -> { where.not(photo: nil) }

  validates :drawing, presence: true
  validates :player, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :tickets_count, numericality: { only_integer: true, greater_than: 0 }

  after_save :update_player_last_entry_id

  def approved?
    status&.to_sym == :approved
  end

  def update_player_last_entry_id
    player.update!(last_entry_id: id)
  end
end
