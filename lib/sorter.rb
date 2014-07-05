require "tsort"

class Sorter
  include TSort

  attr_accessor :sequence

  def initialize(sequence)
    @sequence = sequence
  end

  def tsort_each_node(&block)
    @sequence.each(&block)
  end

  def tsort_each_child(job, &block)
    @sequence.select { |i| i.name == job.name }.first.has_dependency.each(&block)
  end
end