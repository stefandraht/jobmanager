require 'json'
require_relative 'project'

class DataModule

	def self.load_data
		raise NotImplementedError
	end

	def self.save_data(data)
		raise NotImplementedError
	end

end

class JSONDataModule < DataModule

	def self.load_data(file_name)
		project_configs = []
		if File.exists?( file_name )
			data = JSON.parse(File.read( file_name ), :symbolize_names => true) unless File.zero?( file_name )
			project_configs = symbolize_components(data) if data
		end

		project_configs
	end

	def self.save_data(data, file_name)
		File.new(file_name, 'w') unless File.exists? file_name
		File.open(file_name, 'w') do |f|
			f.write( JSON.generate(data) )
		end
	end

	private

	# convert array of strings in item[:components] to symbols
	def self.symbolize_components(items)
		items.each do |item|
			item[:components].collect! { |i| i.to_sym } if item[:components].size
		end
		items
	end

end