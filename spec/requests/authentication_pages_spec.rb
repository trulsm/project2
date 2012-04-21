require 'spec_helper'

describe "Authentication" do

	subject {page}

  describe "sign in page" do
    before {visit signin_path}

    it {should have_selector('h1', text: "Sign in")}
  	it {should have_selector('title', text: "Sign in")}


    describe "with invalid information" do
    	before {click_button "Sign in"}

    	it {should have_selector('title', text: "Sign in")}
    	it {should have_selector('div.alert.alert-error', text: "Invalid")}
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
    	let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        click_button "Sign in"
      end

      it {should have_selector('a', text: "Sign out")}
      it {should have_link('Sign out')}
    end
  end

  describe "sign out" do
    before {visit signout_path}

    it {should have_selector('h1', text: "project2")}
    it {should have_link('Sign in')}
    it {should_not have_selector('a', text: "Account")}

  end
end
