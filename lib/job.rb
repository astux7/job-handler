class Job
  attr_reader :name
  attr_accessor :follows_after,:index,:has_dependency

  def initialize( name = "", has_dependency = false, index = 0, follows_after = nil)
    @index = index
    @name = name
    @has_dependency = has_dependency
    @follows_after = follows_after 
  end

  def follows_after=(value)   
    raise "Job cannot depend on itself" if value === @index 
    @follows_after = value
  end

end