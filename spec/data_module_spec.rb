require 'rspec'
require_relative '../app/data_module'
require_relative '../app/projects'

describe "JSONDataModule" do
	FILE = 'database/test.db'

	before do
		File.delete(FILE) if File.exists?(FILE)
		@data_module = JSONDataModule.new(FILE)
	end

	after :all do
		File.delete(FILE) if File.exists?(FILE)
	end

	####################################
	# #load
	####################################
	describe "#load" do

		subject { @data_module.load() }

		context "when Projects.new is passed" do

			subject { @data_module.load(Projects.new) }

			it { should be_an_instance_of Projects }
		end

		context "when nothing is passed" do
			it { should be_an_instance_of Array }
		end

		context "when a database exists" do

			let(:items) { 
				[
					{job_number: 1, client: "TestClient1", project: "Test Project"},
					{job_number: 2, client: "TestClient2", project: "Test Project"}
				]
			}

			before do
				#File.new(FILE, 'w')
				File.open(FILE, 'w') {|f| f.write(JSON.generate(items))}
			end

			it { should include(items.first) }
			it { should include(items.last) }

		end

		context "when there's no existing database" do
			it { should be_empty }
		end

	end

	####################################
	# #save
	####################################
	describe "#save" do
		before :each do
			# @items = [
			# 		{client: "TestClient1", project: "Test Project"},
			# 		{client: "TestClient2", project: "Test Project"}
			# 	]
			#@data_module.save(@items)
		end

		subject do
			@data_module.save(items)
			return_data = JSON.parse(File.read(FILE), :symbolize_names => true)  if File.exists?(FILE)
			return_data.class == Array ? return_data : [return_data]
		end

		context "when the database is empty" do
			context "when a hash is provided" do
				let(:items) { {client: "TestClient1", project: "Test Project"} }

				it {should have(1).items}

				it { subject.last.should include(items) }
			end

			context "when an array is provided" do
				let(:items) {
					[
						{client: "TestClient1", project: "Test Project"},
						{client: "TestClient2", project: "Test Project"}
					]
				}

				it { should have(2).items }

				it { should include(items.first) }
				it { should include(items.last) }
			end
		end

		context "when the database is not empty" do
			let(:original_data) { {job_number: 1, client: "TestClient1", project: "Test Project"} }

			before :each do
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate([original_data]))
				end
			end

			context "when a hash is provided" do
				let(:items) { {client: "TestClient2", project: "Test Project"} }

				it { should have(2).items }

				it { subject.last.should include(items) }
			end

			context "when an array is provided" do
				let(:items) {
					[
						{client: "TestClient2", project: "Test Project"},
						{client: "TestClient3", project: "Test Project"}
					]
				}

				it { should have(3).items }

				it { should include(items.first) }
				it { should include(items.last) }
			end
		end
		
	end
end