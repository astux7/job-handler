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
    job_handler.input = "c=>c"
    expect(lambda { job_handler.get_job_sequence} ).to raise_error(RuntimeError)
  end

  it 'should scale input to jobs' do
    job_handler.input = "a =>"
    expect(job_handler.get_job_sequence.empty?).to be_false
  end
# check first and last letter if there is a loop!!!!
  it 'should return a given a => ' do
    job_handler.input = "a =>"
    expect(job_handler.get_job_sequence).to eq ('a ')
  end

  it 'should return abc' do
    job_handler.input = "a=>\nb=>\nc=>\n"
    expect(job_handler.get_job_sequence).to eq 'a b c '
  end
  it 'should return ad fcbe ' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne => b\nf =>"
    expect(job_handler.get_job_sequence).to eq 'ad fcbe '
  end
  it 'should return a cb' do
    job_handler.input = "a=>\nb=>c\nc=>\n"
    expect(job_handler.get_job_sequence).to eq 'a cb '
  end
  it 'should raise the error if jobs has the loops on itself' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne =>\nf => b\n"
    expect(lambda { job_handler.get_job_sequence} ).to raise_error(RuntimeError)
  end
  it 'should raise the error if jobs has the loops on itself' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne =>\nf => c\ne=>g\n"
    expect(lambda { job_handler.get_job_sequence } ).to raise_error(RuntimeError)
  end
end