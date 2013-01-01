require 'json'

class DataModule

	def initialize(file_name)
		@data_file = file_name
	end

	def load
		if File.exists?(@data_file)
			puts ">> Loading #{@data_file}. <<"

			lines = []
			File.read(@data_file).each_line do |line|
				lines << line
			end
			lines
		else
			File.new(@data_file, 'w')

			puts ">> #{@data_file} doesn't exist. Creating it. <<"
		end
	end

	def save(data_array)
		puts ">> Saving #{@data_file} <<"

		content = ""
		File.open(@data_file, 'w') do |f|
			f.write(data_array.join("\n"))
		end
	end

end

class JSONDataModule < DataModule


	def load
		if File.exists?(@data_file)
			puts ">> Loading #{@data_file}. <<"
			data = []
			data = JSON.parse(File.read(@data_file), :symbolize_names => true) unless File.zero?(@data_file)
			data
		else
			File.new(@data_file, 'w')
			puts ">> #{@data_file} doesn't exist. Creating it. <<"
			data = []
		end
	end

	def save(data_array)
		puts ">> Saving #{@data_file} <<"

		content = ""
		File.open(@data_file, 'w') do |f|
			f.write(JSON.generate(data_array))
		end
	end

end