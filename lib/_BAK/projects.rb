require_relative 'data_module'
require_relative 'project'

class Projects
	include JSONDataModule

	attr_reader :project_list

	def initialize
		@project_list = []
		populate_from_db()
	end


	
	def build_project(hash)
		add_new_project(hash)
	end


	
	def all
		project_list
	end

	

	def get_by_id(id)
		populate_from_db
		projects = project_list.select {|prj| prj.job_number == id}
		projects ? projects.first : nil
	end

	

	def clear_database
		unless clear_database
			return false
		end
		@project_list = []
		true
	end


	private

	
	def populate_from_db
		project_list.clear
		add_projects load_from_database
	end


	def add_new_project(param_hash)

		if validate_hash(param_hash)
			param_hash[:job_number] = next_job_number

			duplicates = get_duplicates(param_hash)
			if duplicates.any?
				update_project(duplicates.first, hash)
				return {:result => 'update'}
			else
				project = Project.new(param_hash)
				project.execute_components()
				add_to_projectlist( project )
				{:result => 'added'}
			end
		else
			return {:result => 'error'}
		end

	end

	
	def add_projects(hash_array)
		hash_array.each { |hash| @project_list << Project.new(hash) } if hash_array
	end

	def add_to_projectlist(project)
		project_list << project
		save_project_list()
	end

	
	def get_duplicates(project)
		if project.class == Hash
			project_list.select { |i| i.client == project[:client] && i.project_name == project[:project] }
		else
			project_list.select { |i| i.client == project.client && i.project_name == project.project_name }
		end
	end

	
	def update_project(project, hash)
		project.update(hash)
		save_project_list()
	end

	
	def next_job_number
		if project_list.empty?
			1
		else
			sort_projects()
			get_last_job_number + 1
		end
	end

	def get_last_job_number
		project_list.last.job_number
	end

	def sort_projects
		project_list.sort { |a, b| a.job_number <=> b.job_number }
	end

	def save_project_list
		sort_projects
		save_to_database project_list
	end


	def validate_hash(hash)
		valid = true
		valid = false if hash[:client].empty?
		valid = false if hash[:project].empty?
		valid
	end

end