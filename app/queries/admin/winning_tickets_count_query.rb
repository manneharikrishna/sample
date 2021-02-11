class Admin::WinningTicketsCountQuery < ApplicationQuery
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    execute_query(<<~SQL)
      SELECT COUNT(tickets.*)
        FROM tickets
        JOIN drawings
          ON drawings.id = tickets.drawing_id
        JOIN entries
          ON entries.id = tickets.entry_id
        JOIN prizes
          ON prizes.id = tickets.prize_id
       WHERE tickets.drawing_id = #{@drawing.id}
         AND (prizes.reveal_type = 'instant'
             OR (prizes.reveal_type = 'drawing_end'
                AND drawings.ends_at <= now()))
    SQL
  end
end
