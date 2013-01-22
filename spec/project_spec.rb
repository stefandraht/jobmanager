require 'rspec'
require_relative '../lib/application/project'

describe Project do
	
	let(:config_data) { {id: 1, client: "Test Client", title: "Test Project", status: "external"} }

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

	describe "#update" do

		subject { Project.new(config_data) }

		context "when status is provided" do
			let(:new_data) { {id: 1, status: "internal"} }

			it "should have a new status" do
				expect { subject.update(new_data) }.to change{subject.status}.from("external").to("internal")
			end
		end

		context "when components are provided" do
			let(:new_data) { {id: 1, components: ["design_server"]} }

			it "should have a new status" do
				expect { subject.update(new_data) }.to change{subject.components}.from([]).to(["design_server"])
			end
		end

	end

	describe "#name" do
		let(:config_data) { {client: "Test Client", title: "Test Project", status: "external"} }

		subject { Project.new(config_data).name }

		it { should include config_data[:client].sub(' ', '_') }

		it { should include config_data[:title].sub(' ', '_') }

		context "when status is 'external'" do
			it { subject[0].should include 'J' }
		end

		context "when status is 'internal'" do
			let(:config_data) { {client: "Test Client", title: "Test Project", status: "internal", components: []} }

			it { subject[0].should include 'M' }
		end

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