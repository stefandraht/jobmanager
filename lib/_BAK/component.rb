require_relative 'project'
require 'fileutils'

class Component
	attr_reader :name

	def initialize(type)
		extend eval(symbol_to_class(type))
		@name = type.to_s
	end

	def to_s
		name
	end


	private

	def symbol_to_class(sym)
		words = sym.to_s.split('_')
		words = words.inject([]) { |a, w| a << w.capitalize }
		words.join
	end

	

end

module Base
	def flatten_paths(array, string, data)
		if data.is_a? Hash
			data.each {|k, v| flatten_paths(array,"#{string}/#{k.to_s}", v)}
		else
			array << "#{string}/#{data.to_s}"
		end
		array
	end

	def folder_paths(root, folder_hierarchy)
		#puts "folder_paths"
		flatten_paths([], root, folder_hierarchy)
	end
end


module DesignServer
	include Base

	def execute(project)
		design_server_directory = CONFIG[ENVIRONMENT][:design_server]
		folder_hierarchy = DIRECTORIES[ENVIRONMENT][:design_server]
		# create a folder structure based on ::DIRECTORIES[ENVIRONMENT][:design_server]
		paths = folder_paths("#{design_server_directory}/#{project.name}", folder_hierarchy)
		FileUtils.mkdir_p paths # make all the directories in the list including any necessary parent directories
	end

end


module EditServer
	include Base

	def execute(project)
		edit_server_directory = CONFIG[ENVIRONMENT][:edit_server]
		folder_hierarchy = DIRECTORIES[ENVIRONMENT][:edit_server]
		# create a folder structure based on ::DIRECTORIES[ENVIRONMENT][:edit_server]
		folder_hierarchy.each do |root|
			paths = folder_paths("#{edit_server_directory}/#{root.first}/#{project.name}", root.last)
			FileUtils.mkdir_p paths # make all the directories in the list including any necessary parent directories
		end
		
	end
end