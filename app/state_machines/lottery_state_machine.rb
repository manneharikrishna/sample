class LotteryStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :final
  state :ready
  state :started
  state :ended
  state :cancelled

  transition from: :pending, to: :final
  transition from: :final, to: :ready
  transition from: :ready, to: [:started, :cancelled]
  transition from: :started, to: [:ended, :cancelled]

  guard_transition(to: :final) do |lottery|
    lottery_transition_policy(lottery).final?
  end

  def self.lottery_transition_policy(lottery)
    LotteryTransition::PolicyFactory.new(lottery).create
  end
end
