require './lib/job_handler'

if ARGV.first.nil?
  puts 'program reads command input(i.e.) ruby runner.rb "a=>b|b=>"'
else
  begin
    job_handler = JobHandler.new(ARGV.first.gsub("|","\n"))
    job_handler.get_job_sequence
    puts job_handler.output
  rescue => error
    puts error
  end
end
