class Drawing < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :lottery

  has_one :license, through: :lottery

  has_many :prizes, as: :prizeable, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :photos, through: :entries
  has_many :players, through: :entries
  has_many :payments, through: :entries
  has_many :winnings, dependent: :destroy

  has_many :transitions, class_name: 'DrawingTransition'

  def status
    state_machine.current_state.to_sym
  end

  def state_machine
    DrawingStateMachine.new(self, transition_class: DrawingTransition,
      association_name: :transitions)
  end

  def self.transition_name
    :transitions
  end

  def self.initial_state
    DrawingStateMachine.initial_state
  end
end
