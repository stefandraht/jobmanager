require_relative 'projects'
require_relative 'data_module'
require_relative 'initializer'

class Projector
	# @projects
	attr_reader :projects
	attr_accessor :data_module


	def initialize(file = nil)
		puts ">> Initializing Projector. <<"

		config()

		@projects = Projects.new
		if file
			@data_module = JSONDataModule.new(file)
			@data_module.load.each do |item|
				create_project(item)
			end
		end
		
	end

	def create_project(properties_hash)
		@projects << properties_hash
	end

	def write
		@data_module.save(@projects)
	end

	def config
		#@config = Initializer.new('../config/config.yml')
	end

end