require 'rspec'
require_relative '../app/projector'

describe "Projector" do
	
	describe "create_project" do
		before :each do
			@properties = {client: "TestClient", project: "Test Project"}
			@projector = Projector.new('database/test.db')
			@old_size = @projector.projects.length
			@projector.create_project(@properties)
		end

		after :all do
			File.delete('../database/test.db')
		end

		it "should add a project to @projects" do
			@projector.projects.length.should == @old_size + 1
		end

		it "should add a project with the provided properites" do
			@projector.projects.last.client.should == @properties[:client]
			@projector.projects.last.project.should == @properties[:project]
		end
	end

	describe "write" do
		before :each do
			@properties = {client: "TestClient", project: "Test Project"}
			@projector = Projector.new('database/test.db')
			@old_size = @projector.projects.length
			@projector.create_project(@properties)
			@projector.write()
		end

		after :all do
			File.delete('database/test.db')
		end

		it "should save @projects to the database" do
			File.size?('database/test.db').should be > 0
		end

	end

end