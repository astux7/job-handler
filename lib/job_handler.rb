class JobHandler

  attr_accessor :input

  def initialize(input = nil)
    @input = input
  end

  def make_sequence
    return "" if @input.empty?
  end 
  
end