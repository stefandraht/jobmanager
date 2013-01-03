require 'json'

class DataModule

	def initialize(file_name)
		@data_file = file_name
		File.new(file_name, 'w') unless File.exists? file_name
	end

	def load(projects_array)
		# if File.exists?(@data_file)
		# 	puts ">> Loading #{@data_file}. <<"

		# 	#lines = []
		# 	File.read(@data_file).each_line do |line|
		# 		projects_array << line
		# 	end
		# 	projects_array
		# end
	end

	def save(data_array)
		# puts ">> Saving data to #{@data_file} <<"

		# content = ""
		# File.open(@data_file, 'w') do |f|
		# 	f.write(data_array.join("\n"))
		# end
	end

	def clear
		File.delete(@data_file) if File.exists?(@data_file)
	end

end

class JSONDataModule < DataModule


	# load/parse all the json data from the db
	def load(projects_array=nil)
		if File.exists?(@data_file)
			puts ">> Loading #{@data_file}. <<"
			data = JSON.parse(File.read(@data_file), :symbolize_names => true) unless File.zero?(@data_file)
			#projects_array = Projects.new unless projects_array
			projects_array ||= []
			if data.class == Array
				projects_array.concat data
			else
				projects_array << data if data
			end
			projects_array
		end
	end


	# append a hash or an array of hashes representing new projects to the db
	def save(data)
		puts ">> Saving data to #{@data_file} <<"
		original_data = load()

		projects = Projects.new
		original_data.each {|p| projects << p} if original_data.length > 0

		if data.class == Array
			data.each {|p| projects << p}
		else
			projects << data
		end

		File.new(@data_file, 'w') unless File.exists? @data_file
		File.open(@data_file, 'w') do |f|
			f.write(JSON.generate(projects))
		end
	end

end