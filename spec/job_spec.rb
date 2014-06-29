require_relative '../lib/job'

describe Job do

  let(:job) { Job.new("a") }
  let(:job_depending) { Job.new("p", true) }
  it 'should be created with title and not depending on another job a=>' do
    expect(job.name).to eq('a')
  end

  it 'should be created with all properties k => p' do
    job_depending.follows_after = Job.new('k')
    expect(job_depending.has_dependency).to be_true
    expect(job_depending.follows_after.name).to eq 'k' 
  end
  #raise the error if depends on itself
  # it '' do
  #   
  # end
end