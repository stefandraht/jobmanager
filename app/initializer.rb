class Initializer
	def initialize(file)
		@app_config = YAML.load(File.read(File.expand_path(file, __FILE__)))
	end
end