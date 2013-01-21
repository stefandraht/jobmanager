require_relative 'project'
require_relative 'projects'

module ProjectsFactory

	def self.build(project_configs, project_class = Project, projects_class = Projects)
		projects_class.new(
				project_configs.collect { |prj_config| project_class.new(prj_config) }
			)
	end

end


module ProjectFactory

	def self.build(project_config, project_class = Project)
		project = project_class.new(project_config)
		create_components(project.components)
		project
	end

	def self.create_components(components)
		components.each do |component|
			puts component.to_s + " component"
		end
	end
end
