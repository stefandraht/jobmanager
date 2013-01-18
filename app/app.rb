require 'bundler/setup'
Bundler.require(:default)
require_relative 'projector'
require_relative 'helpers/helpers'
require 'sinatra'
require 'sinatra/flash'


class WebApp < Sinatra::Base
	helpers Helpers
	enable :sessions
	register Sinatra::Flash



	get '/' do
		@projects = application.get_all_projects

		erb :index, :layout => :main_layout
	end



	get '/job/:id' do
		@project = application.get_project_by_id(params[:id].to_i)
		@components = @project.component_hash.keys

		erb :job, :layout => :job_layout
	end



	get '/new' do
		erb :new, :layout => :job_layout
	end



	post '/create' do
		client = params[:client]
		project = params[:project]

		result = application.create_project(params)
		case result[:result]
		when "added"
			flash[:success] = "created a new project"
		when "updated"
			flash[:notice] = "updated an existing project"
		when "error"
			flash[:error] = "there was an error"
		end

		redirect '/'
	end



	private

	def application
		Projector.new(:production)
	end
	
end