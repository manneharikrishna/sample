class FilteringQuery
  def initialize(relation, field, value)
    @relation = relation
    @field = field
    @value = value
  end

  def call
    return @relation if @value.nil?
    @relation.where(@field => @value)
  end
end
