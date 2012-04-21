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

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile',  href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end

  # Denne har jeg skrevet selv
  describe "sign out" do
    before {visit signout_path}

    it {should have_selector('h1', text: "project2")}
    it {should have_link('Sign in')}
    it {should_not have_selector('a', text: "Account")}
  end

  describe "authorization" do

    describe "for non signed in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "in the users controller" do
        
        describe "visiting the edit page" do
          before {visit edit_user_path(user)}
          it {should have_selector('title', text: "Sign in")}
        end

        describe "submitting the update action" do
          before {put user_path(user)}
          specify {response.should redirect_to(signin_path)}
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end  
  end
end