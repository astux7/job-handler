require "tsort"
#http://ruby-doc.org/stdlib-1.9.3/libdoc/tsort/rdoc/TSort.html

class JobSorter
  include TSort

  attr_accessor :sequence

  def initialize(sequence)
    @sequence = sequence
  end

  def tsort_each_node(&block)
    @sequence.each(&block)
  end

  def tsort_each
    each_strongly_connected_component {|component|
      if component.size == 1
        yield component.first
      else
        raise Cyclic.new("Circle in the job sequence: Topological sort failed")
      end
    }
  end

  def tsort_each_child(job, &block)
    @sequence.select { |i| i.name == job.name }.first.has_dependency.each(&block)
  end
end