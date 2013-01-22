require_relative 'project'

class Projects < Array

	def initialize(*projects)
		projects.flatten!
		projects.each do |prj| 
			self << prj
		end
	end

	def <<(project)
		project.id ||= next_id
		if validate_project(project)
			self.push project 
		else
			false
		end
	end

	def get_by_id(id)
		select {|project| project.id == id}.first
	end


	def sort_projects
		sort! {|a,b| a.id <=> b.id}
	end


	def last_id
		if length > 0
			sort_projects
			last.id
		else
			0
		end
	end

	private

	def next_id
		last_id + 1
	end

	def validate_project(project)
		duplicates = select {|i| i.client == project.client && i.title == project.title}
		duplicates.size > 0 ? false : true
	end

end
