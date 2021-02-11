class PaginationQuery
  def initialize(relation, page, per_page)
    @relation = relation
    @page = page
    @per_page = per_page
  end

  def call
    return @relation if @per_page.blank?
    @relation.page(@page).per(@per_page)
  end
end
