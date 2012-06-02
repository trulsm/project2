require 'spec_helper'

describe "ProjectPages" do

	subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  before { sign_in user }

  describe "project creation" do
  	before {visit user_path(user)}
  	it {should have_selector('a', text: "new project")}
  end

  describe "new project page" do
  	before {visit new_project_path}

  	it {should have_selector('h1', text: "New Project")}
  	it {should have_selector('title', text: "New Project")}

  	describe "submitted with invalid information" do
  		before do
        fill_in "Name",         with: "  "
        fill_in "Description",  with: "This is an example description"
  		end
      it "should not create a project" do
        expect { click_button 'Save Project'}.should_not change(Project, :count)
      end

  	end

  	describe "submitted with valid information" do

  		before do
        fill_in "Name",         with: "Example project"
        fill_in "Description",  with: "This is an example description"
  		end
      it "should create a project" do
        expect { click_button "Save Project" }.should change(Project, :count).by(1)
      end
  	end
  end

  describe "project show page" do
  	before {visit project_path(project)}

  	it {should have_selector('h1', text: project.name)}
  	it {should have_selector('title', text: project.name)}
    
    describe "submit data entry with invalid information" do
      it "should not create a log" do
        expect { click_button "Save Log" }.should_not change(Log, :count)
      end

    end

    describe "submit data entry with valid information" do

      before do
        fill_in "Float entry",         with: (1+rand(6))
        fill_in "Log date",            with: Date.current
      end
      it "should create a project" do
        expect { click_button "Save data entry" }.should change(Log, :count).by(1)
      end
    end
  end
end
