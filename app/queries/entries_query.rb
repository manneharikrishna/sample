class EntriesQuery
  def initialize(player, params)
    @player = player
    @params = params
  end

  def call
    paginate(sort_by_creation_time(@player.entries))
  end

  private

  def sort_by_creation_time(relation)
    relation.order(created_at: :desc)
  end

  def paginate(relation)
    PaginationQuery.new(relation, @params[:page], @params[:per_page]).call
  end
end
