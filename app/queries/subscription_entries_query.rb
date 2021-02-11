class SubscriptionEntriesQuery
  def initialize(player, drawing)
    @player = player
    @drawing = drawing
  end

  def call
    sort_by_creation_time(filter_by_drawing(filter_by_subscription(unrevealed_entries)))
  end

  private

  def unrevealed_entries
    @player.entries.not_revealed
  end

  def filter_by_subscription(relation)
    relation.where(entry_type: 'subscription')
  end

  def filter_by_drawing(relation)
    relation.where(drawing: @drawing)
  end

  def sort_by_creation_time(relation)
    relation.order(created_at: :desc)
  end
end
