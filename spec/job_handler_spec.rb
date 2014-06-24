require_relative '../lib/job_handler'

describe JobHandler do

  let(:job_handler) { JobHandler.new() }

  it 'should init the JobHandler' do
    expect(job_handler.input.nil?).to be_true
  end

  it 'returns empty string for empty input' do
    job_handler.input = ""
    expect(job_handler.make_sequence).to eq ""
  end
end