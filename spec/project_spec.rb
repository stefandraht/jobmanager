require 'rspec'
require_relative '../lib/application/project'

describe Project do
	
	let(:config_data) { {client: "Test Client", title: "Test Project", status: "external"} }

	subject { Project.new(config_data) }

	it { should respond_to :name }

	it { should respond_to :to_json }

	context "when no arguments are provided" do
		subject { Project.new() }

		it { subject.client.should include "ClientName" }

		it { subject.title.should include "Project_Title" }

		it { subject.status.should include "external" }

		it { subject.id.should be nil }
	end

	describe "#name" do
		let(:config_data) { {client: "Test Client", title: "Test Project", status: "external"} }

		subject { Project.new(config_data).name }

		it { should include config_data[:client].sub(' ', '_') }

		it { should include config_data[:title].sub(' ', '_') }

	end

	describe "#hashify" do
		subject { Project.new(config_data).hashify }

		it "should produce the correct hash" do
			should == config_data
		end
	end

	describe "#to_json" do
		subject { Project.new(config_data).to_json }
	end
end