class DrawingStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :ready
  state :started
  state :ended
  state :cancelled

  transition from: :pending, to: :ready
  transition from: :ready, to: [:started, :cancelled]
  transition from: :started, to: [:ended, :cancelled]
end
