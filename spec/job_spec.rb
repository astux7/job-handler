require_relative '../lib/job'

describe Job do

  let(:job) { Job.new('a',[]) }
  let(:job_depending) { Job.new('a',['b'])}
  it 'should be created with name and not depending on another job a=>' do
    expect(job.name).to eq('a')
    expect(job.has_dependency.empty?).to be_true
  end

  it 'should be created with name and has has_dependency properties a => b ' do
    expect(job_depending.has_dependency.count).to eq 1
    expect(job_depending.name).to eq 'a' 
  end
  
end