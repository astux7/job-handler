class Job
  attr_reader :name, :has_dependency
  attr_accessor :follows_after, :flaged

  def initialize( name = "", has_dependency = false, follows_after = nil)
    @name = name
    @has_dependency = has_dependency
    @follows_after = follows_after
  end

  #TODO raise the error if object depends on itself

  # def follows_after
  # end
end