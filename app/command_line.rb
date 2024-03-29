require 'optparse'
require_relative 'requirements'

class OptParser

	def self.parse(args)
		puts ">> Parsing options <<"

		options = {}

		opts = OptionParser.new do |opts|
			# client option
			opts.on("-c", "--client [STRING]", "The client name.") do |client|
				options[:client] = client || ""
			end

			# project option
			opts.on("-p", "--project [STRING]", "The project title.") do |project|
				options[:project] = project || ""
			end
		end

		opts.parse!(args)
		options
	end

end


class CommandLineInterface
	
	def initialize
		@application = Projector.new(:production)
	end

	def add(options)
		puts ">> Adding project <<"
	  @application.create_project(options, {:design_server => true, :edit_server => true})
		list()
	end

	def list
		puts ">> Listing projects: <<"

		projects = @application.get_all_projects()

		if projects
			projects.each { |project| puts "#{project.name}" }
		else
			puts "* empty database *"
		end
	end

	def getbyid
		puts ">> Project: <<"

		project = @application.get_project_by_id(1)

		if project
			puts project.name
		else
			puts "* empty database *"
		end
	end

	def write
		@application.write
	end

	def clear
		@application.clear()
		list()
	end

	def parse_options(args)
		options = OptParser.parse(args)
		if options.length > 0
			send(args[0], options)
		else
			send args[0]
		end
	end

end

cli = CommandLineInterface.new
cli.parse_options ARGV
#cli.write