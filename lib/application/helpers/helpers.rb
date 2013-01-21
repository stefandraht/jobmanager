module Helpers
	
	def link_to_project(project)
		%(<a href="/job/#{project.id}">#{project.name}</a>)
	end

	def link_to(title, path)
		%(<a href="#{path}">#{title}</a>)
	end

end