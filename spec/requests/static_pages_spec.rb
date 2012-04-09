require 'spec_helper'

describe "StaticPages" do

  it "should have the right base titles" do
    visit root_path
    page.should have_selector('title', text: "Project2")
    visit help_path
    page.should have_selector('title', text: "Project2")
    visit about_path
    page.should have_selector('title', text: "Project2")
    visit contact_path
    page.should have_selector('title', text: "Project2")
  end

  subject {page}

  describe "Home Page" do
    before {visit root_path}

    it {should have_content('Home')}
    it {should have_selector('title', text: "Home")}
  end
    
  describe "Help page" do
    before {visit help_path}

    it {should have_content('help')}
    it {should have_selector('title', text: "Help")}
  end

  describe "About page" do
    before {visit about_path}

    it {should have_content('About us')}
    it {should have_selector('title', text: "About us")}
  end

  describe "Contact page" do
    before {visit contact_path}

    it {should have_content('Contact')}
    it {should have_selector('title', text: "Contact")}
  end
end
