
class Project
	attr_accessor :client, :project, :internal, :job_number

	def initialize(param_hash)
		@client = param_hash[:client]
		@project = param_hash[:project]
		@internal = param_hash[:internal] ? true : false
		@job_number = param_hash[:job_number]
	end

	def to_s
		{job_number: @job_number, client: @client, project: @project}.to_s
	end

	def name
		prefix = @internal ? 'M' : 'J'
		formatted_job_number = "%04d" % @job_number
		client = @client.sub(' ', '_')
		project = @project.sub(' ', '_')
		"#{prefix}#{formatted_job_number}_#{client}_#{project}"
	end

	def to_json(*arg)
		{
			:job_number => @job_number,
			:client => @client, 
			:project => @project
		}.to_json(*arg)
	end

	def hashify
		{job_number: @job_number, client: @client, project: @project}
	end
end