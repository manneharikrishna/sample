module PaginationHelper
  def total_pages(relation)
    relation.try(:total_pages) || 1
  end
end
