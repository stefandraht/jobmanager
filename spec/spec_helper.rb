require_relative '../app/app.rb'
require 'rubygems'
require 'sinatra'
require 'rspec'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
	WebApp.new!  # sinatra overrides .new with .new!
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
