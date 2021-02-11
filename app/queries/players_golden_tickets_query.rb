class PlayersGoldenTicketsQuery < ApplicationQuery
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    execute_query(Player, <<~SQL)
          SELECT players.*, COUNT (tickets.id) AS golden_tickets
            FROM players
      INNER JOIN entries ON entries.player_id = players.id
       LEFT JOIN tickets ON tickets.entry_id = entries.id
       LEFT JOIN prizes ON prizes.id = tickets.prize_id
           WHERE tickets.drawing_id = '#{@drawing.id}'
             AND tickets.revealed_at IS NULL
             AND (prize_id IS NULL OR prizes.reveal_type = 'drawing_end')
        GROUP BY players.id
    SQL
  end

  private

  def execute_query(model, sql)
    model.from("(#{sql}) AS #{model.table_name}")
  end
end
