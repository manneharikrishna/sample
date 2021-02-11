ActivationPolicy = Struct.new(:player, :activation) do
  def create?
    player.not_activated?
  end
end
