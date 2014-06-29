require_relative 'job'

class JobHandler

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
    make_job_sequence
  end

  #every job unit 'a=>b' separated with new line
  def correct_job_sequence_input
    jobs = @input.delete(' ').split("\n")
    raise "Unknown job squence" if jobs.any?{|job| correct_job_unit?(job) == false }
    raise "Job cannot depend on itself" if jobs.any?{|job| correct_job_dependency?(job) == false }
  end

  #the user input checker: a => , a=>n, a=> n, a => h..
  def correct_job_unit?(job)
    parse_job_input(job).nil? ? false : true
  end

  def correct_job_dependency?(job)
    job_unit = parse_job_input(job)
    job_unit[1] != job_unit[3]
  end

  def parse_job_input(job)
    JOB_UNIT_INPUT_TEMPLATE.match(job)
  end

  def job_list
    job_container = []
    @input.delete(' ').split("\n").each do |job| 
      job_unit = parse_job_input(job)
      job_container <<  Job.new(job_unit[1],(job_unit[3].empty? ? false : true))
      if job_container.last.has_dependency
        job_container.last.follows_after = job_container.count
        job_container <<  Job.new(job_unit[3]) unless job_container.any?{|job| job.name == job_unit[3]}
        
      end
    end
    puts job_container.inspect
    job_container
  end

  def make_job_sequence
    tmp = ""
    job_list.each do |job|
      tmp = job.name
      if job.has_dependency
        #puts job_list[job.follows_after].inspect
        @output += job_list[job.follows_after].name +  tmp
      else
       @output += tmp + " "
      end

    end
    #puts job_list[job.follows_after].inspect
  
    #job_list
    @output
  end

end