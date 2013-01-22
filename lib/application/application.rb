require_relative 'core_ext'
require_relative 'factories'
require_relative 'data_module'
require_relative 'project'

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
		new_project = Project.new(args)
		if projects << new_project
			ComponentFactory.build(new_project.components)
			JSONDataModule.save_data(projects, DATABASE)
		end
	end


	def update_project(args)
		project = get_project_by_id(args[:id].to_i)
		project.update(args)
		new_components = (args[:components] ||= []) - project.components
		JSONDataModule.save_data(projects, DATABASE)
	end


end



# prj = {
# 	client: "Client",
# 	title: "Title",
# 	components: [:design_server]
# }

# app = Application.new
# #app.create_new_project(prj)
# app.update_project({id: 1, status: "external"})
# puts app.get_all_projects
