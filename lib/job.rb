class Job
  attr_reader :name
  attr_accessor :follows_after_index, :index, :has_dependency

  def initialize( name = "", has_dependency = false, index = -1, follows_after_index = nil)
    @index = index
    @name = name
    @has_dependency = has_dependency
    raise "Job cannot depend on itself" if follows_after_index == index 
    @follows_after_index = follows_after_index 
  end

  def follows_after_index=(value)   
    raise "Job cannot depend on itself" if value == @index
    @follows_after_index = value
  end

end