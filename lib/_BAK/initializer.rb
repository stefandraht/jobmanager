require_relative '../lib/hash'
require 'YAML'

class Initializer

	def self.init(file_path)
		CONFIG_FILES.each do |file_name|
		  tmp = YAML.load(File.read(File.expand_path("#{file_path}#{file_name}.yml", __FILE__)))
		  tmp.symbolize_keys! if tmp.class == Hash
		  eval("::#{file_name.upcase} = tmp")
		end
	end
	
end