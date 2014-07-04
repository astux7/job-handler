require_relative '../lib/job_sorter'

describe JobSorter do
  let(:job_sorter){ JobSorter.new()}
 it 'should init the JobHandler nil input and empty string for output' do
    expect(job_sorter.input.nil?).to be_true
    expect(job_sorter.output.empty?).to be_true
  end

  it 'returns empty string for empty input' do
    job_sorter.input = ""
    expect(job_sorter.get_job_sequence).to eq ""
  end

  it 'raise the error about unrecognized input' do
    job_sorter.input = "8=> p"
    expect(lambda { job_sorter.get_job_sequence} ).to raise_error(RuntimeError)
    job_sorter.input = "u => l\np =>8"
    expect(lambda { job_sorter.get_job_sequence} ).to raise_error(RuntimeError)
  end

end