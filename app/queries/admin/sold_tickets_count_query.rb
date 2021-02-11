class Admin::SoldTicketsCountQuery < ApplicationQuery
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    @drawing.tickets.joins(:entry).count
  end
end
