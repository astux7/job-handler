class Job
  attr_reader :name
  attr_accessor :has_dependency

  def initialize( name = "", has_dependency = [])
    @name = name
    @has_dependency = has_dependency
  end

end