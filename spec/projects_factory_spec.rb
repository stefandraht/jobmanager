require 'rspec'
require_relative '../lib/application/projects'
require_relative '../lib/application/projects_factory'

describe ProjectsFactory do

	let(:config_data) { [{client: "Test Client", title: "Test Project", status: "external"}] }
	
	subject { ProjectsFactory.build(config_data) }
	
	it { should be_an_instance_of Projects }

	it { subject.first.hashify.should include config_data.first }

	context "when an empty config array is provided" do
		let(:config_data) { [] }
	
		it { should be_an_instance_of Projects }

		it { should be_empty }
	end
end