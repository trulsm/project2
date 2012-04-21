require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  before {@project = user.projects.build(name: "Lorem ipsum")}

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description)}
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
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
end# == Schema Information
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

