# == Schema Information
#
# Table name: logs
#
#  id          :integer         not null, primary key
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  float_entry :float
#  log_date    :date
#

require 'spec_helper'

describe Log do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  before do
    @log = project.logs.build(float_entry: 1, log_date: Date.current)
  end

	subject {@log}

	it {should respond_to(:project_id)}
  it {should respond_to(:float_entry)}
  it {should respond_to(:log_date)}  
  its(:project) { should == project }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Log.new(project_id: project.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   
  end

  describe "when project_id is not present" do
    before { @log.project_id = nil }
    it { should_not be_valid }
  end
end
