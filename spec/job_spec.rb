require_relative '../lib/job'

describe Job do

  let(:job) { Job.new("a",false) }
  let(:job_depending) { Job.new("p", true, 0, 1) }
  it 'should be created with title and not depending on another job a=>' do
    expect(job.name).to eq('a')
  end

  it 'should be created with name and has has_dependency properties p => x' do
    expect(job_depending.has_dependency).to be_true
    expect(job_depending.name).to eq 'p' 
  end

  it 'should raise the error if job depends on itself' do
    c = Job.new("c", true, 0) 
    expect(lambda { c.follows_after_index = 0} ).to raise_error(RuntimeError)
    expect(lambda { Job.new("t", true, 0, 0) } ).to raise_error(RuntimeError)
  end

  it 'should create the job with all properties' do
    expect(job_depending.name).to eq 'p' 
    expect(job_depending.has_dependency).to be_true
    expect(job_depending.index).to eq 0
    expect(job_depending.follows_after_index).to eq 1
  end

end