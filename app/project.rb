
class Project
	attr_accessor :content

	def initialize(param_hash)
		# dynamically create instance variables from a hash
		param_hash.each do |name, value|
			self.instance_variable_set("@#{name}", value)  # create instance variable
			self.class.send(:define_method, name, proc{self.instance_variable_get("@#{name}")})		# create getter method for new variable
      self.class.send(:define_method, "#{name}=", proc{|value| self.instance_variable_set("@#{name}", value)})	# create setter method for variable
		end
	end

	def to_s
		@content
	end

	def name
		"#{client}_#{project}"
	end

	def to_json(*arg)
		{:client=>@client, :project=>@project}.to_json(*arg)
		# self.instance_variables.inject({}) {|hash,var| hash[var[1..-1].to_sym] = instance_variable_get(var); hash}
		# self.instance_variables.each do |var|
		# 	hash[var.to_s.delete("@").to_sym] = self.instance_variable_get(var)
		# end
		# puts hash
		# hash.to_json(*arg)
	end

end