require 'rspec'
require 'spec_helper'
require_relative '../app/projects'

describe "Projects" do
	FILE = 'database/test.db'

	before :all do
		Initializer.init('../../config/')
		::ENVIRONMENT = :test
	end

	before :each do
		@projects = Projects.new
	end

	####################################
	# #build_project
	####################################
	describe "#build_project" do

		subject { @projects.build_project(param_hash) }

		context "when it receives a valid hash" do
			let(:param_hash) { {client: "Test Client", project: "Test Project", components: nil} }

			it { should be_true }
		end

		context "when it receives an invalid hash" do
			let(:param_hash) { {client: "Test Client2", foo: "bar"} }

			it { should  be_false }
		end

	end

	####################################
	# #all
	####################################
	describe "#all" do

		before :each do
			@projects = Projects.new
		end

		subject { @projects.all.inject([]) {|a, i| a<<i.hashify } }

		context "when the database is empty" do

			before :all do 
				module JSONDataModule
					def load_from_database
						[]
					end
				end
			end

			it { should be_an_instance_of Array }

			it { should be_empty }

		end

		context "when the database contains items" do

			before :all do 
				@data = [
						{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
						{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
					]

				module JSONDataModule
					def load_from_database
						[
							{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
							{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
						]
					end
				end
			end

			it { should be_an_instance_of Array }

			it { should include @data.first }

			it { should include @data.last }
		end

	end

	####################################
	# #get_by_number
	####################################
	describe "#get_by_id" do

		let(:job_number) { 1 }

		subject { @projects.get_by_id(job_number) }

		context "when the database is empty" do

			before :all do 
				module JSONDataModule
					def load_from_database
						[]
					end
				end
			end

			#it { should be_an_instance_of NilClass }

			#it { should be_nil }

		end

		context "when the databse contains items" do

			before :all do 
				@data = [
					{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
					{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
				]

				module JSONDataModule
					def load_from_database
						[
							{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
							{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
						]
					end
				end
			end

			it { should be_an_instance_of Project }

			it { subject.job_number.should == 1 }

		end

	end

	####################################
	# #clear_database
	####################################
	describe "#clear_database" do

		subject { @projects.clear_database }

	end

end