class PhotosQuery
  def initialize(player)
    @player = player
  end

  def call
    execute_query(Photo, <<~SQL)
      SELECT photos.*, COUNT(tickets.id) AS winning_count
        FROM photos
   LEFT JOIN entries
          ON entries.photo_id = photos.id
             AND entries.player_id = '#{@player.id}'
   LEFT JOIN tickets
          ON tickets.entry_id = entries.id
             AND tickets.revealed_at IS NOT NULL
             AND tickets.prize_id IS NOT NULL
       WHERE photos.player_id IS NULL
             OR photos.player_id = '#{@player.id}'
    GROUP BY photos.id
    ORDER BY winning_count DESC,
             photos.player_id DESC,
             photos.created_at DESC
    SQL
  end

  private

  def execute_query(model, sql)
    model.from("(#{sql}) AS #{model.table_name}")
  end
end
