class ApplicationQuery
  private

  def execute_query(sql)
    ActiveRecord::Base.connection.exec_query(sql).rows[0][0]
  end
end
