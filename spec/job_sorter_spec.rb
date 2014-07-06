require_relative '../lib/job_sorter'
require_relative '../lib/job_handler'

describe JobSorter do

  let(:job_handler) { JobHandler.new() }

  it 'should init sorter' do
    sort = JobSorter.new([])
    expect(sort.sequence.empty?).to be_true
  end

  it 'should raise the error if jobs has the loops on itself' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne =>\nf => b\n"
    job_handler.create_job_container
    expect { JobSorter.new(job_handler.job_container).tsort }.to raise_error("Circle in the job sequence: Topological sort failed")
  end

end