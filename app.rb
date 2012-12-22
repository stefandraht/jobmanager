require 'bundler/setup'
Bundler.require(:default)

class WebApp < Sinatra::Base
	get '/' do
		'Hello world!'
	end

	def new_project(args_hash)
		# project = Project.new(args_hash[:client], args_hash[:project], args_hash[:external])
		# if project.save
		# 	true
		# else
		# 	false
		# end
	end
end

class Project

	def initialize(client, project, external = true)
		@client     = client.sub(' ', '_')
		@project    = project.sub(' ', '_')
		@prefix     = external ? 'J' : 'M'
		@job_number = create_job_number()
		@name       = build_name()
	end

	def create_job_number
		
	end

	def build_name
		unless @job_number
			@job_number = create_job_number()
		end

		"#{@prefix}#{@job_number}_#{@client}_#{@project}"
	end

end