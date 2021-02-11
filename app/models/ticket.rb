class Ticket < ApplicationRecord
  LOCK_TYPE = 'FOR UPDATE SKIP LOCKED'.freeze
  PRIZES = [25, 50, 250, 1000].freeze

  belongs_to :drawing
  belongs_to :prize
  belongs_to :entry

  has_one :player, through: :entry

  has_many :ticket_autoreveals
  has_many :winnings, foreign_key: :ticket_id

  has_event :reveal

  scope :winning, -> { where.not(prize: nil) }
  scope :non_winning, -> { where(prize: nil) }

  validates :drawing, presence: true

  def self.next(count = nil)
    order(:id).lock(LOCK_TYPE).take(count)
  end

  def self.random
    offset = RNG.random_number(count)
    order(:id).offset(offset).lock(LOCK_TYPE).take
  end

  def self.approved
    joins(:entry).where(entries: { status: 'approved' })
  end

  def self.reveal_all
    update_all(revealed_at: Time.current)
  end

  # setting default values to scratch_state attribute
  def set_metadata
    self.scratch_state = Array.new(3) { Array.new(3, tile) }
  end

  def tile
    { 'prize': nil, 'revealed': false }
  end

  # generating prize for non winning ticket
  def non_win_prize
    non_win_arr = ['SnapChanceTicket'] * 3
    2.times { non_win_arr << PRIZES.shuffle.take(3) }
    non_win_arr.flatten.shuffle
  end

  def win_prize(prize)
    win_arr = [prize]*3
    2.times { win_arr << (PRIZES - [prize]).shuffle.take(3) }
    win_arr.flatten.shuffle
  end

  # generating scratch state for non winning ticket
  def non_win_scratch_state(scratch_state_data)
    set_metadata
    prizes = scratch_state_data.each_slice(3).to_a
    scratch_state.map.with_index do |x, i|
      x.map.with_index do |y, j|
        scratch_state[i][j]['prize'] = prizes[i][j].to_s
      end
    end
    self.scratch_state
  end
end
