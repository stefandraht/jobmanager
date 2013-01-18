require 'rspec'
require_relative '../app/data_module'
require_relative '../app/projects'

# describe "JSONDataModule" do
# 	FILE = 'database/test.db'

# 	before do
# 		File.delete(FILE) if File.exists?(FILE)
# 		@data_module = JSONDataModule.new(FILE)
# 	end

# 	after :all do
# 		File.delete(FILE) if File.exists?(FILE)
# 	end

# 	####################################
# 	# #load
# 	####################################
# 	describe "#load" do

# 		subject { @data_module.load() }

# 		context "when database is empty" do

# 			it { should be_empty }

# 		end

# 		context "when database contains items" do
# 			let(:db_items) {
# 				[
# 					{job_number: 1, client: "TestClient1", project: "Test Project", components: nil},
# 					{job_number: 2, client: "TestClient2", project: "Test Project", components: nil}
# 				]
# 			}

# 			before do
# 				File.open(FILE, 'w') do |f|
# 					f.write(JSON.generate(db_items))
# 				end
# 			end

# 			it { should include(db_items.first) }

# 			it { should include(db_items.last) }
# 		end

# 	end

# 	####################################
# 	# #save
# 	####################################
# 	describe "#save" do
		
# 		subject { 
# 			@data_module.save(item) 
# 			return_data = JSON.parse(File.read(FILE), :symbolize_names => true)  if File.exists?(FILE)
# 		}

# 		let(:item) { {client: "TestClient1", project: "Test Project"} }

# 		it { should include(item) }

# 	end
# end