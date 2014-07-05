require "tsort"

class Project
  attr_accessor :dependents, :name
  def initialize(name)
    @name = name
    @dependents = []
  end
end

class Sorter
  include TSort

  def initialize(col)
    @col = col
  end

  def tsort_each_node(&block)
    @col.each(&block)
  end

  def tsort_each_child(project, &block)
    @col.select { |i| i.name == project.name }.first.dependents.each(&block)
  end
end


b = Project.new "b"
#job_handler.input = "a =>\nb => c\nc => f\nd => a\ne => b\nf =>\n"
c = Project.new "c"

f= Project.new "f"

a = Project.new "a"
d = Project.new "d"
e = Project.new "e"
c.dependents << f
b.dependents << c
d.dependents << a
e.dependents << b



col = [a,b,c,d,e,f]

result = Sorter.new(col).tsort
puts result.map(&:name).inspect