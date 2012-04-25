require 'spec_helper'

describe Logs do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
	before {@log = user.projects.logs.build(name: "Sleep",
																					description: "How much sleep")}

	subject {@log}

	it {should respond_to(:name)}
	it {should respond_to(:description)}
	it {should respond_to(:project_id)}


end
