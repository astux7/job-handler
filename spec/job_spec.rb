require_relative '../lib/job'

describe Job do

  let(:job) { Job.new('a',[]) }
  let(:job_depending) { Job.new('b',[job])}
  it 'should be created with name and not depending on another job a=>' do
    expect(job.name).to eq('a')
    expect(job.has_dependency.empty?).to be_true
  end

  it 'should be created with name and has has_dependency properties a => b ' do
    expect(job_depending.has_dependency.first).to eq job
    expect(job_depending.name).to eq 'b' 
  end
  
  it 'should raise the error if job depends on itself' do
    c = Job.new('c')
    expect(lambda { c.add_to_has_dependency(c)} ).to raise_error(StandardError)
  end
end