require 'spec_helper'

describe "UserPages" do

	subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:project, user: user, name: "Foo") }
    let!(:p2) { FactoryGirl.create(:project, user: user, name: "Bar") }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "projects" do
      it { should have_content(p1.name) }
      it { should have_content(p2.name) }
      it { should have_content(user.projects.count) }
    end
  end

  describe "Signup page" do
  	before {visit signup_path}

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }    
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  {"New Name"}
      let(:new_email) {"new@example.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password_confirmation
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  #Prøver meg på noen users-page tester:
  describe "users page" do

    describe "for non-admins" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end
      it {should_not have_selector('a', text: "Users")}
    end

    describe "for admins" do
      let(:admin) {FactoryGirl.create(:admin)}
      before do
        sign_in admin
      end
      it {should have_selector('a', text: "Users")}
    end
  end

  describe "index" do

    describe "pagination" do
    let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end
      # Fyll inn testing av pagination
    end

    describe "should allow access for admins" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end
      it { should have_selector('title', text: 'All users') }
      it { should_not have_link('delete', href: user_path(admin)) } 
    end

    describe "should deny access for non-admins" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit users_path
      end

      it {should have_selector('title', text: "Home")}
    end
  end
end
