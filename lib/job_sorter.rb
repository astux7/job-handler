class JobSorter

  attr_accessor :input, :output, :job_container

  JOB_UNIT_INPUT_TEMPLATE = /(^[a-z]{1}\s{1}?)(=>)(|(\s{1}?[a-z]{1}?))$/

  def initialize(input = nil, output = "")
    @input = input
    @output = output
    @job_container = []
  end

  #get the sequence for output
  def get_job_sequence
    return @output if @input.empty?
    correct_job_sequence_input
    @output
  end

  #every job unit 'a=>b' separated with new line
  def correct_job_sequence_input
    jobs = @input.delete(' ').split("\n")
    raise "Unknown job squence" if jobs.any?{|job| correct_job_unit?(job) == false }
  end

  #the user input checker: a => , a=>n, a=> n, a => h..
  def correct_job_unit?(job)
    parse_job_input(job).nil? ? false : true
  end

  def parse_job_input(job)
    JOB_UNIT_INPUT_TEMPLATE.match(job)
  end



end