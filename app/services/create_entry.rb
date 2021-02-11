class CreateEntry
  include StrategyHelper

  def initialize(drawing, player, params)
    @drawing = drawing
    @player = player
    @params = params
  end

  def call
    drawing.transaction do
      create_entry.tap do |entry|
        strategy(entry).call
        schedule_tickets_count_change_tracking
      end
    end
  end

  private

  attr_reader :drawing
  attr_reader :player
  attr_reader :params

  def create_entry
    drawing.entries.create! do |entry|
      entry.player = player
      entry.photo = photo
      entry.tickets_count = tickets_count
      entry.entry_type = entry_type
    end
  end

  def photo
    @photo ||= photos.find_by!(id: params[:photo_id])
  end

  def photos
    Photo.where(player: [nil, player])
  end

  def tickets_count
    params[:tickets_count].presence || 1
  end

  def entry_type
    params[:entry_type]
  end

  def schedule_tickets_count_change_tracking
    TrackTicketsCountChangeJob.perform_later(player, tickets_count)
  end

  def strategy(entry)
    strategy_class.new(entry, params)
  end
end
