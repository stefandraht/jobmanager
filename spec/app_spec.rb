require 'spec_helper'

describe "Sinatra App" do
	
	it "should respond to GET" do
		get '/'
		last_response.should be_ok
		last_response.body.should match(/Hello world!/)
	end

	describe "new_project" do 
		before(:each) do
			@client = "AgencyName"
			@project = "ProjectName"
			@external = true
		end

		describe "when it's a client project" do

			it "should have a 'J' job number" do
				
			end

		end

		describe "when it's an internal project" do
			before(:each) do
				@external = false
			end

			it "should have an 'M' job number" do

			end

		end

		it "should incrememnt the job number" do

		end

		it "should return true on success, with no file conflicts" do
			project = app.new_project(@client, @project, @external)
			project.should be_an_instance_of Project
		end

		it "should return false on failure, with file conflicts" do

		end

	end

end