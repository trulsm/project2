# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  before {@project = user.projects.build(name: "Lorem ipsum")}

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description)}
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:logs)}
	its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @project.name = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Project.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "log associations" do

    before { @project.save }
    let!(:newer_log) do 
      FactoryGirl.create(:log, project: @project, created_at: 1.day.ago, log_date: Date.current)
    end
    let!(:older_log) do
      FactoryGirl.create(:log, project: @project, created_at: 1.hour.ago, log_date: 1.day.ago.to_date)
    end

    it "should have the right logs in the right order" do
      @project.logs.should == [newer_log, older_log]
    end

    it "should destroy associated logs" do
      logs = @project.logs
      @project.destroy
      logs.each do |log|
        Log.find_by_id(log.id).should be_nil
      end
    end
  end
end
