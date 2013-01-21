require_relative 'components'

class Project
	attr_accessor :client, :project_name, :internal, :job_number, :components

	def initialize(param_hash)
			@client       = param_hash[:client]
			@project_name = param_hash[:project]
			@internal     = param_hash[:internal] || false
			@job_number   = param_hash[:job_number]
			@components   = Components.new( param_hash[:components] )
	end

	def update(param_hash)
		components = Components.new( param_hash[:components] )
	end

	def execute_components
		components.execute( self )
	end

	def to_s
		{ job_number: job_number, client: client, project: project_name, components: components }.to_s
	end

	def name
		prefix = internal ? 'M' : 'J'
		formatted_job_number = "%04d" % @job_number
		cl = client.sub(' ', '_')
		pr = project_name.sub(' ', '_')
		"#{prefix}#{formatted_job_number}_#{cl}_#{pr}"
	end

	def to_json(*arg)
		{
			:job_number => job_number,
			:client => client, 
			:project => project_name,
			:components => component_hash
		}.to_json(*arg)
	end

	def hashify
		{ job_number: job_number, client: client, project: project_name, components: components }
	end

	def component_hash
		@components.hashify
	end

end