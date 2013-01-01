require 'rspec'
require_relative '../app/data_module'

describe "JSONDataModule" do
	FILE = 'database/test.db'

	before :each do
		File.delete(FILE) if File.exists?(FILE)
	end

	after :each do
		File.delete(FILE) if File.exists?(FILE)
	end

	describe "load()" do

		describe "when a database exists" do
			before :each do
				File.new(FILE, 'w')
				@items = [
					{client: "TestClient1", project: "Test Project"},
					{client: "TestClient2", project: "Test Project"}
				]
				File.open(FILE, 'w') do |f|
					f.write(JSON.generate(@items))
				end

				@data_module = JSONDataModule.new(FILE)
			end

			it "should return each line from the file" do
				lines = @data_module.load()
				lines.first.should == {client: "TestClient1", project: "Test Project"}
				lines.last.should == {client: "TestClient2", project: "Test Project"}
			end
		end

		describe "when there's no existing database" do
			before :each do
				@data_module = JSONDataModule.new(FILE)
			end

			it "should create a new database file" do
				@data_module.load()
				File.exists?(FILE).should be_true
			end

			it "should return an empty array" do
				@data_module.load.should be_an_instance_of Array
				@data_module.load.empty?.should be_true
			end

		end

	end

	describe "save()" do
		before :each do
			@items = [
					{client: "TestClient1", project: "Test Project"},
					{client: "TestClient2", project: "Test Project"}
				]
			@data_module = JSONDataModule.new(FILE)
			@data_module.save(@items)
		end

		it "should save a database file with the given items" do
			data = []
			data = JSON.parse(File.read(FILE), :symbolize_names => true)
			data.first.should == @items.first
			data.last.should == @items.last
		end
	end
end