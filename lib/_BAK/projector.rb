require_relative 'projects'
require_relative 'Initializer'

CONFIG_FILES = ["config", "directories"]

class Projector


	def initialize(environment)
		Initializer.init('../../config/')
		eval("::ENVIRONMENT = environment")
	end
	


	def get_all_projects
		projects.all
	end



	def get_project_by_id(id)
		projects.get_by_id(id)
	end



	def create_project(param_hash, component_flags = nil)
		param_hash[:components] = component_flags
		projects.build_project(param_hash)
	end



	def clear
		projects.clear_database()
	end



	private

	def projects
		Projects.new
	end

end