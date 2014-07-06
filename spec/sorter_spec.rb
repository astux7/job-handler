require_relative '../lib/sorter'
require_relative '../lib/job_handler'

describe Sorter do

  let(:job_handler) { JobHandler.new() }

  it 'should init sorter' do
    sort = Sorter.new([])
    expect(sort.sequence.empty?).to be_true
  end

  it 'should raise the error if jobs has the loops on itself' do
    job_handler.input = "a =>\nb => c\nc => f\nd => a\ne =>\nf => b\n"
    job_handler.create_job_container
    expect { Sorter.new(job_handler.job_container).tsort }.to raise_error("Circle in the job sequence: Topological sort failed")
  end

end