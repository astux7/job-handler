require_relative '../lib/job_handler'

describe JobHandler do

  let(:job_handler) { JobHandler.new() }

  it 'should init the JobHandler nil input and empty string for output' do
    expect(job_handler.input.nil?).to be_true
    expect(job_handler.output.empty?).to be_true
  end

  it 'returns empty string for empty input' do
    job_handler.input = ""
    expect(job_handler.get_job_sequence).to eq ""
  end

  it 'raise the error about unrecognized input' do
    job_handler.input = "8=> p"
    expect(lambda { job_handler.get_job_sequence} ).to raise_error(RuntimeError)
    job_handler.input = "u => l\np =>8"
    expect(lambda { job_handler.get_job_sequence} ).to raise_error(RuntimeError)
  end

  it 'should not raise the error if correct input' do
    job_handler.input = "k => g"
    expect(job_handler.get_job_sequence.empty?).to be_false
    job_handler.input = "k => g\np => "
    expect(job_handler.get_job_sequence.empty?).to be_false
  end

  it 'should raise the error if job depends on itself' do
    job_handler.input = "a=>\nb=>\nc=>c"
    expect(lambda { job_handler.get_job_sequence} ).to raise_error(StandardError)
  end

  it 'should scale input to jobs' do
    job_handler.input = "a =>"
    expect(job_handler.get_job_sequence.empty?).to be_false
  end

  it 'should return a for a given a => ' do
    job_handler.input = "a =>"
    expect(job_handler.get_job_sequence).to eq ('a')
  end

  it 'should return abc for a given structure' do
    job_handler.input = "a=>\nb=>\nc=>\n"
    expect(job_handler.get_job_sequence).to eq 'abc'
  end

  it 'should return a before d  and f before c before b before e for a given structure' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne => b\nf =>\n" 
    result = job_handler.get_job_sequence.split("")
    expect(result.find_index{|item| 'a'} < result.find_index{|item| 'd'})
    expect(result.find_index{|item| 'f'} < result.find_index{|item| 'c'})
    expect(result.find_index{|item| 'b'} < result.find_index{|item| 'e'})
  end

  it 'should return a cb for a given structure' do
    job_handler.input = "a=>\nb=>c\nc=>\n"
    expect(job_handler.get_job_sequence).to eq 'acb'
  end


end