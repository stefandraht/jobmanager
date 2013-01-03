require_relative 'project'
class Projects < Array

	def add_project(hash)
		hash[:job_number] = generate_job_number() unless hash[:job_number]
		prj = Project.new(hash)
		# find duplicates, if they exist
		dup = self.select {|i| i.client == prj.client && i.project == prj.project }
		# avoid duplicates
		self.push prj unless dup.length > 0
		sort_projects()
	end

	def <<(hash)
		add_project(hash)
	end

	def sort_projects
		self.sort {|a,b| a.job_number <=> b.job_number}
	end

	def generate_job_number
		if self.empty?
			1
		else
			self.sort_projects()
			self.last_job_number + 1
		end
	end

	def last_job_number
		self.last.job_number
	end

	def concat(hash_array)
		hash_array.each do |hash|
			add_project(hash)
		end
	end

	def include?(hash)
		self.select {|pr| pr.hashify == hash }
	end

end