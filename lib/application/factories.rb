require_relative 'project'
require_relative 'projects'
require_relative 'components'

module ProjectsFactory

	def self.build(project_configs, project_class = Project, projects_class = Projects)
		projects_class.new(
				project_configs.collect { |prj_config| project_class.new(prj_config) }
			)
	end

end


# module ProjectFactory

# 	def self.build(project_config, project_class = Project)
# 		project = project_class.new(project_config)
# 		project
# 	end


# end

module ComponentFactory
	def self.build(component_config, component_class = Component)
		component_config.each do |component|
			component_class.build(component)
		end
	end
end
