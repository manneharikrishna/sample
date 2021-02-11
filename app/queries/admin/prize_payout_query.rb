class Admin::PrizePayoutQuery < ApplicationQuery
  def initialize(prize)
    @prize = prize
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
       WHERE prizes.id = #{@prize.id}
         AND (prizes.reveal_type = 'instant'
             OR (prizes.reveal_type = 'drawing_end'
                AND drawings.ends_at <= now()))
    SQL
  end
end
