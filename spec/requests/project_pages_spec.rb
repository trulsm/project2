require 'spec_helper'

describe "ProjectPages" do

	subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "project creation" do
  	before {visit user_path(user)}
  	it {should have_selector('a', text: "new project")}
  end
end
