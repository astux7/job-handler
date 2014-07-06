require_relative 'program_error'
require 'tsort'
require_relative 'sorter'
require_relative 'job'

class JobHandler

  include TSort
  attr_accessor :input, :output, :job_container

  JOB_UNIT_INPUT_PATTERN = /(^[a-z]{1}\s{1}?)(=>)(|(\s{1}?[a-z]{1}?))$/

  def initialize(input = nil, output = "")
    @input = input
    @output = output
    @job_container = []
  end

  #get the sequence for output
  def get_job_sequence
    return @output if @input.empty?
    check_job_sequence_input
    process_input
  end

  def process_input
    create_job_container
    sort_jobs
  end

  def sort_jobs
    result = Sorter.new(@job_container).tsort
    @output = result.map(&:name).join("")
  end

   def create_job_container
    @input.delete(' ').split("\n").each do |job| 
      unit = parse_job_input(job)
      add_job_to_container(unit)
    end
  end

  def add_job_to_container(unit)
    find_object_index = find_job_index_in_container(unit[1])
    find_object_index.nil? ? job_not_created(unit) : job_created(unit,find_object_index)
  end

  def find_job_index_in_container(unit)
    @job_container.find_index{|item| item.name == unit}
  end

  def job_not_created(job_unit)
    @job_container << create_job(job_unit[1])
    index = @job_container.count-1
    create_job_dependency(job_unit, index)
  end

  def job_created(job_unit, find_object)
    create_job_dependency(job_unit,find_object)
  end

  def create_job_dependency(job_unit, find_object)
    return if job_unit[3].empty? 
    dependency_index = find_job_index_in_container(job_unit[3])
    job = find_job_index_in_container(job_unit[3]).nil? ? create_job(job_unit[3]) : @job_container[dependency_index]
    @job_container[find_object].add_to_has_dependency(job)
  end

  def create_job(unit)
    job = Job.new(unit) 
    @job_container << job
    job
  end
  
  #every job unit 'a=>b' separated with new line
  def check_job_sequence_input
    jobs = @input.delete(' ').split("\n")
    raise "Unknown job squence input" if jobs.any?{|job| correct_job_unit?(job) == false }
  end

  #the user input checker: a => , a=>n, a=> n, a => h..
  def correct_job_unit?(job)
    parse_job_input(job).nil? ? false : true
  end

  def parse_job_input(job)
    JOB_UNIT_INPUT_PATTERN.match(job)
  end

end