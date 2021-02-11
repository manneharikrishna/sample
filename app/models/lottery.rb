class Lottery < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  TYPES = %w[pool predrawn social].freeze

  belongs_to :license

  has_many :transitions, class_name: 'LotteryTransition'

  has_many :prizes, as: :prizeable, dependent: :destroy
  has_many :drawings

  mount_uploader :cover, CoverUploader

  def type
    license.lottery_type
  end

  def status
    state_machine.current_state.to_sym
  end

  def state_machine
    LotteryStateMachine.new(self, transition_class: LotteryTransition,
      association_name: :transitions)
  end

  def self.transition_name
    :transitions
  end

  def self.initial_state
    LotteryStateMachine.initial_state
  end
end
