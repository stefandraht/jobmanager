require 'bundler/setup'
Bundler.require(:default)
require 'sinatra'
require 'sinatra/flash'
require_relative 'application/application'
require_relative 'application/helpers/helpers'


class WebApp < Sinatra::Base
	helpers Helpers
	enable :sessions
	register Sinatra::Flash
	attr_reader :application



	get '/' do
		@projects = app.get_all_projects

		erb :index, :layout => :main_layout
	end


	get '/job/:id' do
		@project = app.get_project_by_id(params[:id].to_i)

		erb :job, :layout => :job_layout
	end


	get '/new' do

		erb :new, :layout => :job_layout
	end


	get '/job/:id/edit' do
		@project = app.get_project_by_id(params[:id].to_i) 

		erb :edit, :layout => :job_layout
	end


	post '/create' do
		app.create_new_project(params)

		flash[:notice] = "New job added."
		redirect '/'
	end

	post '/update' do
		app.update_project(params)

		flash[:notice] = "Updated project."
		redirect "/job/#{params[:id]}"
	end



	private

	def app
		#application ||= Application.new
		Application.new
	end
	
end