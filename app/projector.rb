require_relative 'project'
require_relative 'data_module'
require 'json'

class Projector
	# @projects
	attr_reader :projects
	attr_accessor :data_module


	def initialize(file)
		puts ">> Initializing Projector. <<"

		@projects = []
		@data_module = JSONDataModule.new(file)

		@data_module.load.each do |item|
			create_project(item)
		end
	end

	def create_project(hash)
		@projects << Project.new(hash)
	end

	def write
		@data_module.save(@projects)
	end


end


class CommandLineInterface
	
	def initialize
		@application = Projector.new('database/jobs.db')
		@application.create_project({:client=>"DDB", :project=>"test"})
	end

	def add
		puts ">> Adding project <<"
		@application.create_project ARGV[1]
		list()
	end

	def list
		puts ">> Listing projects: <<"

		@application.projects.each do |project|
			puts "#{project.name}"
		end
	end

	def write
		@application.write
	end

end

cli = CommandLineInterface.new
cli.send ARGV[0]
cli.write