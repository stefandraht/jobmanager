require 'rspec'
require 'json'
require_relative '../app/projector'

describe "Projector" do
	FILE = 'database/test.db'

	before :each do
		File.delete(FILE) if File.exists?(FILE)
		@api = Projector.new
		@api.set_database FILE
	end

	after :all do
		File.delete(FILE) if File.exists?(FILE)
	end
	
	####################################
	# #get_all_projects
	####################################
	describe "#get_all_projects" do

		subject { @api.get_all_projects() }

		context "when the database contains projects" do

			let(:items) {
				[
					{job_number: 1, client: "TestClient1", project: "Test Project"},
					{job_number: 2, client: "TestClient2", project: "Test Project"}
				]
			}

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(items))
				end
			end

			it { should be_an_instance_of Projects }

			it "it returns all the projects from the database" do
				puts items.first.class
				should include(items.first)
				should include(items.last)
			end

		end

		context "when the database contains one project" do

			let(:item) { {job_number: 1, client: "TestClient1", project: "Test Project"} }

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(item))
				end
			end

			it { should be_an_instance_of Projects }
			
			it { subject.first.client.should include(item[:client]) }

		end

		context "when the database is empty" do

			before do 
				File.delete(FILE) if File.exists?(FILE)
			end

			it { should be nil }

		end
	end

	####################################
	# #create_new_project
	####################################
	describe "#create_new_project" do

		subject do
			@api.create_new_project(data)
			return_data = JSON.parse(File.read(FILE), :symbolize_names => true)  if File.exists?(FILE)
			return_data.class == Array ? return_data : [return_data]
		end

		context "when the database is emtpy" do

			let(:data) { {job_number: 1, client: "TestClient1", project: "Test Project"} }

			it { should have(1).items }

			it { should include data }
		end

		context "when the database is not empty" do

			context "and when there is a unique client" do
				
				let(:original_data) { {job_number: 1, client: "TestClient1", project: "Test Project"} }
				let(:data) { {client: "TestClient2", project: "Test Project"} }

				before :each do
					File.open(FILE, 'w') do |f|
						f.write(JSON.generate([original_data]))
					end
				end

				it { should have(2).items }

				it "should append an item to the database" do
					should include data
					should include original_data
				end

			end

			context "when there is a duplicate client" do

				let(:original_data) { {job_number: 1, client: "TestClient1", project: "Test Project"} }
				let(:data) { {client: "TestClient1", project: "Test Project"} }
				
				before :each do
					File.open(FILE, 'w') do |f|
						f.write(JSON.generate([original_data]))
					end
				end

				it { should have(1).items }

			end
		end

		context "when the design-server flag is set" do
		end

		context "when the edit-server flag is set" do
		end

	end

end