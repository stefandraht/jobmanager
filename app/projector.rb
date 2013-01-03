require_relative 'data_module'
require_relative 'projects'

class Projector

	def initialize
		
	end
	

	# return an array containing all the projects from the db
	def get_all_projects
		@data_module.load(Projects.new)
	end


	# create a new project in the db, based on parameter hash
	def create_new_project(param_hash, component_flags = nil)
		@data_module.save(param_hash)
	end

	#clear the current database
	def clear
		@data_module.clear()
	end

	# set the database path
	# create it if it doesn't exist
	def set_database(file)
		@data_module = JSONDataModule.new file
	end

end