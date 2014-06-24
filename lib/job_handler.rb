class JobHandler

  attr_accessor :input, :output

  JOB_UNIT_INPUT_TEMPLATE = /(^[a-z]{1}\s{1}?)(=>)(|(\s{1}?[a-z]{1}?))$/

  def initialize(input = nil, output = "")
    @input = input
    @output = output
  end
  #make the sequence for output
  def make_sequence
    return @output if @input.empty?
    raise "Unknown job squence" unless correct_job_sequence_input?
    @input
  end
  #every job unit 'a=>b' separated with new line
  def correct_job_sequence_input?
    jobs = @input.split("\n")
    !jobs.any?{|job| correct_job_unit?(job) == false }
  end
  #the user input checker: a => , a=>n, a=> n, a => h..
  def correct_job_unit?(job)
    JOB_UNIT_INPUT_TEMPLATE.match(job).nil? ? false : true
  end
end