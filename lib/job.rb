class Job

  attr_reader :name

  def initialize( name = "", has_dependency = [])
    @name = name
    @has_dependency = has_dependency
  end

  def add_to_has_dependency(value)
    raise(StandardError, "Job cannot depend to itself") if value == self
    @has_dependency << value
  end

  def has_dependency
    raise(StandardError, "Job cannot depend to itself") if @has_dependency.include?(self)
    @has_dependency
  end
end