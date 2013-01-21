require 'json'

# Baseclass for DataModules
module DataModule

	def load
	end

	def save(data)
	end

	# Public: Constructor for DataModule
	#
	# file_name  -  The path to the database file.
	#
	# Examples
	#
	#   DataModule.new
	#
	# def initialize(file_name)
	# 	@data_file = file_name
	# 	File.new(file_name, 'w') unless File.exists? file_name
	# end

	# Public: Clear the database.
	#
	# Examples
	#
	#   clear_database()
	#   # => true
	#
	# Returns true or false
	def clear_database
		begin
			File.delete( CONFIG[ENVIRONMENT][:database] ) if File.exists?(@data_file)
			true
		rescue
			false
		end
	end

end

module JSONDataModule
	include DataModule

	# Public: Load and parse json data from the database.
	#
	# Examples
	#
	#   load_from_database()
	#   # => [Hash, Hash, Hash]
	#
	# Returns an array of hashes
	def load_from_database
		data_file = CONFIG[ENVIRONMENT][:database]
		if File.exists?( data_file )
			data = JSON.parse(File.read( data_file ), :symbolize_names => true) unless File.zero?( data_file )

			projects_array = []
			if data.class == Array
				projects_array.concat data
			else
				projects_array << data if data
			end
			projects_array
		end
	end


	# Public: Save data as json to the database.
	#
	# data  -  The data object to be converted to JSON and saved.
	#
	# Examples
	#
	#   save_to_database(Project.new)
	#   # => true
	#
	# Returns true or false
	def save_to_database(data)
		data_file = CONFIG[ENVIRONMENT][:database]
		begin
			puts ">> Saving data to #{@data_file} <<"
			original_data = load()

			File.new(data_file, 'w') unless File.exists? data_file
			File.open(data_file, 'w') do |f|
				f.write(JSON.generate(data))
			end
			true
		rescue
			false
		end
	end

end