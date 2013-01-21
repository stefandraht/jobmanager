require 'rspec'
require 'json'
require_relative '../lib/application/data_module'

FILE = 'database/test.db'

shared_examples_for DataModule do

	subject { data_module }

	it { should respond_to :load_data }

	it { should respond_to :save_data }
	
	describe ".load_data" do
		subject { data_module.load_data(FILE) }

		it { should respond_to :each }
	end

	describe ".save_data" do

	end

end

def read_database
	return_data = JSON.parse(File.read(FILE), :symbolize_names => true) if File.exists?(FILE)
	if return_data
		return_data.each do |item|
			item[:components].collect! { |i| i.to_sym }
		end
	end
end

def populate_database(data)
	File.open(FILE, 'w') do |f|
		f.write(JSON.generate(data))
	end
end

describe JSONDataModule do
	let(:data_module) { JSONDataModule }
	it_behaves_like DataModule

	describe ".load_data" do
		subject { data_module.load_data(FILE) }

		let(:data) {
			[
				{id: 1, client: "test client", title: "test title", status: "external", components: [:design_server, :edit_server]},
				{id: 2, client: "test client2", title: "test title2", status: "internal", components: [:design_server]}
			]
		}

		before :each do 
			populate_database(data)
		end

		it "should load the correct amount of data from the database" do
			subject.should have(2).items
		end

		it "should load the correct data fom the database" do
			subject.should include data.first
		end
	end

	describe ".save_data" do

		before :each do 
			File.delete(FILE) if File.exists?(FILE)
		end

		after :all do
			File.delete(FILE) if File.exists?(FILE)
		end

		let(:data) {
			[
				{id: 1, client: "test client", title: "test title", status: "external", components: [:design_server, :edit_server]},
				{id: 2, client: "test client2", title: "test title2", status: "internal", components: [:design_server]}
			]
		}

		it "the database should have 2 items" do
			data_module.save_data(data, FILE)
			read_database.should have(2).items
		end

		it "the database should contain all the data" do
			data_module.save_data(data, FILE)
			read_database.should include data.first
		end

	end
end