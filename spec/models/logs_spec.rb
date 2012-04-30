# == Schema Information
#
# Table name: logs
#
#  id         :integer         not null, primary key
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  data_reg   :integer
#

require 'spec_helper'

describe Logs do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
	before {@log = project.logs.build(data_reg: 1)}

	subject {@log}

	it {should respond_to(:project_id)}
  it {should respond_to(:data_reg)}
  its(:project) { should == project }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Log.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   
  end

  describe "when project_id is not present" do
    before { @log.project_id = nil }
    it { should_not be_valid }
  end
end
