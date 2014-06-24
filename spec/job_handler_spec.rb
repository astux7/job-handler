require_relative '../lib/job_handler'

describe JobHandler do

  let(:job_handler) { JobHandler.new() }

  it 'should init the JobHandler nil input and empty string for output' do
    expect(job_handler.input.nil?).to be_true
    expect(job_handler.output.empty?).to be_true
  end

  it 'returns empty string for empty input' do
    job_handler.input = ""
    expect(job_handler.make_sequence).to eq ""
  end

  it 'raise the error about unrecognized input' do
    job_handler.input = "8=> p"
    expect(lambda { job_handler.make_sequence} ).to raise_error(RuntimeError)
    job_handler.input = "u => l\np =>8"
    expect(lambda { job_handler.make_sequence} ).to raise_error(RuntimeError)
  end

  it 'should not raise the error if correct input' do
    job_handler.input = "k => g"
    expect(job_handler.make_sequence.empty?).to be_false
    job_handler.input = "k => g\np=>"
    expect(job_handler.make_sequence.empty?).to be_false
  end

end