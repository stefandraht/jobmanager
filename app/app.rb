require 'bundler/setup'
Bundler.require(:default)
require_relative 'projector'


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