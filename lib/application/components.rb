class Component

	def initialize(component_name)
		extend eval( symbol_to_class(component_name) )
	end


	def self.build(component_name)
		Component.new(component_name).execute
	end


	private

	def symbol_to_class(sym)
		words = sym.to_s.split('_')
		words = words.inject([]) { |a, w| a << w.capitalize }
		words.join
	end

end


module DesignServer

	def execute
		puts "designer_server component"
	end

end

module EditServer

	def execute
		puts "edit_server component"
	end

end