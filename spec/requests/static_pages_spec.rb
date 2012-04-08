require 'spec_helper'

describe "StaticPages" do

  it "should have the right base titles" do
    visit '/static_pages/home'
    page.should have_selector('title', :text => "Project2")
    visit '/static_pages/help'
    page.should have_selector('title', :text => "Project2")
    visit '/static_pages/about'
    page.should have_selector('title', :text => "Project2")
  end

  describe "Home Page" do
    it "should have the content 'Home'" do
      visit '/static_pages/home'
      page.should have_content('home')
    end

    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Home")
    end
  end
    
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('help')
    end

    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Help")
    end
  end

  describe "About page" do

    it "should have the content 'About us'" do
      visit '/static_pages/about'
      page.should have_content('About us')
    end

    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "About us")
    end
  end
end
