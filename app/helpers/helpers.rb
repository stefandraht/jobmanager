module Helpers
	
	def link_to_project(project)
		%(<a href="/job/#{project.job_number}">#{project.name}</a>)
	end

	def link_to(title, path)
		%(<a href="#{path}">#{title}</a>)
	end

end