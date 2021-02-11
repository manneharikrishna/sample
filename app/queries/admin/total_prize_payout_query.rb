class Admin::TotalPrizePayoutQuery < ApplicationQuery
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    execute_query(<<~SQL)
      SELECT SUM(prizes.value)
        FROM prizes
        JOIN drawings
          ON (drawings.id = prizes.prizeable_id
             AND prizes.prizeable_type = 'Drawing')
        JOIN tickets
          ON tickets.prize_id = prizes.id
        JOIN entries
          ON entries.id = tickets.entry_id
       WHERE prizes.prizeable_id = #{@drawing.id}
         AND prizes.prizeable_type = 'Drawing'
         AND (prizes.reveal_type = 'instant'
             OR (prizes.reveal_type = 'drawing_end'
                AND drawings.ends_at <= now()))
    SQL
  end
end
