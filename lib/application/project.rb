class Project
	attr_accessor :client, :title, :status, :id, :components


	def initialize(args={})
		@client = args[:client] ||= client_default
		@title = args[:title] ||= title_default
		@status = args[:status] ||= "external"
		@id = args[:id] ||= nil
		@components = args[:components] ||= []
	end


	def update(args)
		@status = args[:status] if args[:status]
		@components += args[:components] if args[:components]
	end


	def name
		"#{prefix}#{padded_job_number}_#{client_formatted}_#{title_formatted}"
	end


	def to_s
		name
	end

	def hashify
		{id: id, client: client, title: title, status: status, components: components}
	end

	def to_json(*arg)
		{
			:id => id,
			:client => client, 
			:title => title,
			:components => components,
			:status => status
		}.to_json(*arg)
	end

	private

	def client_formatted
		client.sub(' ', '_')
	end


	def title_formatted
		title.sub(' ', '_')
	end

	def client_default
		"ClientName"
	end

	def title_default
		"Project_Title"
	end

	def prefix
		status == "external" ? "J" : "M"
	end

	def padded_job_number
		id ? "%04d" % id : "xxxx"
	end
end