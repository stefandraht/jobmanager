require 'rspec'
require_relative '../lib/application/projects'

class ProjectDouble
	attr_accessor :id, :name, :client, :title

	def initialize(id=nil, client=nil, title=nil)
		@id = id
		@client = client ||= "Client#{rand(1000)}"
		@title = title ||= "Title#{rand(1000)}"
	end
end


describe Projects do

	it { should respond_to :each }

	it { should respond_to :size }

	context "when a single project is passed" do
		let(:project) { ProjectDouble.new }

		subject { Projects.new(project) }

		it { should include project }

		it { should have(1).items }

		context "and project has id already" do

			subject { Projects.new(ProjectDouble.new(10)) }

			it "should have a project with id = 10" do
				subject.first.id.should be 10
			end

		end

		context "and project doesn't already have id" do
			it "should have a project with id = 1" do
				subject.first.id.should be 1
			end
		end
	end

	context "when an array of projects is passed" do

		let(:projects_array) { [ProjectDouble.new, ProjectDouble.new] }

		subject { Projects.new(projects_array) }

		it { should include projects_array.first }

		it { should include projects_array.last }

		context "and projects have ids already" do
			let(:projects_array) { 
				projectA = ProjectDouble.new(10)
				projectB = ProjectDouble.new(11)
				[projectA, projectB] 
			}

			it "should have a project with id = 10" do
				subject.first.id.should be 10
			end

			it "should have a project with id = 11" do
				subject.last.id.should be 11
			end

		end

		context "and projects don't already have ids" do

			it "should have a project with id = 1" do
				subject.first.id.should be 1
			end

			it "should have a project with id = 2" do
				subject.last.id.should be 2
			end
		end
	end

	describe "<<" do
		let(:project) { ProjectDouble.new }

		subject { 
			projects = Projects.new
			projects << project 
		}

		it { should include project }

		it { should have(1).items }

		context "when a project already exists with the same client and title" do
			let(:project) { ProjectDouble.new(nil, "Test Client", "Test Title") }

			let(:new_project) { ProjectDouble.new(nil, "Test Client", "Test Title") }

			subject { 
				projects = Projects.new(project)
				projects  << new_project
			}

			it { should be false }
		end
	end


	describe "#get_by_id" do

		let(:projects_array) { [ProjectDouble.new(1), ProjectDouble.new(2)] }

		subject { Projects.new(projects_array).get_by_id(1) }

		it { should respond_to :name }

		it { subject.id.should be 1 }

	end

	describe "#sort_projects" do
		let(:projects_array) { [ProjectDouble.new(2), ProjectDouble.new(1)] }

		subject { Projects.new(projects_array).sort_projects }

		it { subject.first.id.should be 1 }
	end

	describe "last_id" do
		let(:projects_array) { [ProjectDouble.new(4), ProjectDouble.new(1)] }

		subject { Projects.new(projects_array).last_id }

		it { should be 4 }
	end

end