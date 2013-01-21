require 'rspec'
require 'json'
require_relative '../app/projector'

describe "Projector" do
	FILE = 'database/test.db'

	before :all do
		@api = Projector.new(:test)
	end

	before :each do 
		File.delete(FILE) if File.exists?(FILE)
	end

	after :all do
		File.delete(FILE) if File.exists?(FILE)
	end
	
	####################################
	# #get_all_projects
	####################################
	describe "#get_all_projects" do

		subject { @api.get_all_projects().inject([]) {|a,i| a << i.hashify} }

		it { should be_an_instance_of Array }

		context "when the database contains projects" do

			let(:db_items) {
				[
					{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
					{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
				]
			}

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(db_items))
				end
			end

			it { should include(db_items.first) }

			it { should include(db_items.last) }

		end

		context "when the database contains one project" do

			let(:item) { {job_number: 1, client: "TestClient1", project: "Test Project", components: nil} }

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(item))
				end
			end
			
			it { subject.first.should == item }

		end

		context "when the database is empty" do

			before do 
				File.delete(FILE) if File.exists?(FILE)
			end

			it { should be_empty }

		end
	end

	####################################
	# #create_new_project
	####################################
	describe "#create_project" do

		subject do
			@api.create_project(data)
			return_data = JSON.parse(File.read(FILE), :symbolize_names => true)  if File.exists?(FILE)
			return_data = return_data.select {|i| i != nil} if return_data
			#return_data.class == Array ? return_data : [return_data]
		end

		let(:data) { {client: "TestClient1", project: "Test Project"} }

		it "should be and instance of Hash" do
			@api.create_project(data).should be_an_instance_of Hash
		end

		context "when the database is emtpy" do

			it { should have(1).items }

			it { should include data }
		end

		context "when the database is not empty" do

			context "and when there is a unique client" do
				
				let(:original_data) { {job_number: 1, client: "TestClient1", project: "Test Project", components: nil} }
				let(:data) { {client: "TestClient2", project: "Test Project"} }

				before :each do
					File.open(FILE, 'w') do |f|
						f.write(JSON.generate([original_data]))
					end
				end

				it { should have(2).items }

				it { should include original_data }

				it { should include data }

			end

			context "when there is a duplicate client" do

				let(:original_data) { {job_number: 1, client: "TestClient1", project: "Test Project", components: nil} }
				
				before :each do
					File.open(FILE, 'w') do |f|
						f.write(JSON.generate([original_data]))
					end
				end

				it { should have(1).items }

				it { should include original_data }

				it { should_not include data }

			end
		end

	####################################
	# #get_project_by_id(id)
	####################################
	describe "#get_project_by_id(id)" do

		subject { @api.get_project_by_id(1) }

		context "when the database contains the job number" do

			let(:db_items) { {job_number: 1, client: "TestClient1", project: "Test Project", components: nil} }

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(db_items))
				end
			end

			it { should be_an_instance_of Project }

		end

		context "when the database doesn't contain the job number" do

			let(:item) { {job_number: 2, client: "TestClient1", project: "Test Project", components: nil} }

			before do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(item))
				end
			end
			
			it { should be_nil }

		end
	end

		context "when the design-server flag is set" do
			# it should craete a design server folder structure
		end

		context "when the edit-server flag is set" do
			# it should craete a design server folder structure
		end

	end

end