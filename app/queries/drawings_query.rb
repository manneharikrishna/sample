class DrawingsQuery < ApplicationQuery
  def call
    Drawing.in_state(:started)
  end
end
