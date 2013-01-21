require_relative 'factories'
require_relative 'data_module'

class Application
	attr_reader :projects
	DATABASE = 'database/jobs_database.db'

	def initialize
		@projects = ProjectsFactory.build( JSONDataModule.load_data(DATABASE) )
	end


	def get_all_projects
		projects
	end


	def get_project_by_id(id)
		projects.get_by_id(id)
	end


	def create_new_project(args)
		projects << ProjectFactory.build(args)
		JSONDataModule.save_data(projects, DATABASE)
	end


	def update_project(args)
		projects.update_project(args)
	end


end



prj = {
	client: "Client",
	title: "Title",
	components: [:design_server]
}

# app = Application.new
# app.create_new_project(prj)
# puts app.get_all_projects
