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
    create_job_container
    make_job_sequence
    @output
  end

  #every job unit 'a=>b' separated with new line
  def correct_job_sequence_input
    jobs = @input.delete(' ').split("\n")
    raise "Unknown job squence" if jobs.any?{|job| correct_job_unit?(job) == false }
   # raise "Job cannot depend on itself" if jobs.any?{|job| correct_job_dependency?(job) == false }
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

  def job_not_created(job_unit,find_object)
    @job_container <<  Job.new(job_unit[1],(job_unit[3].empty? ? false : true), @job_container.count)
    add_dependency_to_new_job(job_unit) 
  end

  def job_created(job_unit,find_object)
    @job_container[find_object].has_dependency = true unless job_unit[3].empty?
    add_dependency_to_found_job(job_unit,find_object) 
  end

  def create_job_container
    @input.delete(' ').split("\n").each do |job| 
      unit = parse_job_input(job)
      find_object = @job_container.find_index{|item| item.name == unit[1]}
      find_object.nil? ? job_not_created(unit,find_object) : job_created(unit,find_object)
    end
  end

  def add_dependency_to_new_job(job_unit) 
    if @job_container.last.has_dependency
      index = job_container.find_index{|item| item.name == job_unit[3]} 
      @job_container.last.follows_after = index.nil? ? @job_container.count : index
      @job_container <<  Job.new(job_unit[3],false, @job_container.count)  if index.nil?
    end
  end
  def add_dependency_to_found_job(job_unit,find_object) 
    if @job_container[find_object].has_dependency
      index = job_container.find_index{|item| item.name == job_unit[3]} 
      @job_container[find_object].follows_after = index.nil? ? @job_container.count : index
      @job_container <<  Job.new(job_unit[3],false, @job_container.count)  if index.nil?
    end
  end

  def make_job_sequence      #new sequence c=> or a=>
    sequence_starters = @job_container.select{|job| job unless job.has_dependency}
    sequence_starters.each{|job|
      @output += job.name
      search_dependency_sequence(job)
      @output += " "
    }
  end

  def search_dependency_sequence(job)
    index =  @job_container.find_index{|j| j.follows_after == job.index}
    unless index.nil?
      @output += @job_container[index].name
      search_dependency_sequence(@job_container[index])
    end
  end
 
end