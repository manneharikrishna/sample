class Admin::EntriesQuery < ApplicationQuery
  def initialize(drawing, params = {})
    @drawing = drawing
    @params = params
  end

  def call
    paginate(sort_by_creation_time(filter_by_status(@drawing.entries.with_photo)))
  end

  private

  attr_reader :params

  def filter_by_status(relation)
    FilteringQuery.new(relation, :status, params[:status]).call
  end

  def sort_by_creation_time(relation)
    SortingQuery.new(relation, :created_at, params[:order]).call
  end

  def paginate(relation)
    PaginationQuery.new(relation, params[:page], params[:per_page]).call
  end
end
