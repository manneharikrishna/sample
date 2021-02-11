class RevealEntries
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    reveal_entries
    update_revealed_at
  end

  private

  attr_reader :drawing

  def reveal_entries
    unrevealed_entries.each do |entry|
      RevealEntry.new(entry, :subscription).call
    end
  end

  def unrevealed_entries
    @unrevealed_entries ||= Entry.where(revealed_at: nil, drawing: drawing)
  end

  def update_revealed_at
    unrevealed_entries.update(revealed_at: drawing.ends_at)
  end
end
