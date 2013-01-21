require_relative 'component'

class Components
	attr_reader :component_hash, :components

	def initialize(comp_hash)
		@component_hash = clean_hash( comp_hash )
		@components     = setup_components( component_hash )
	end

	def execute(project)
		if components
			components.each { |component| component.execute(project) }
		end
	end

	def hashify
		component_hash
	end

	private

	def clean_hash(raw_hash)
		comp_hashes = {}
		if raw_hash && !raw_hash.empty?
			comp_hashes = raw_hash.select {|k, v| v}
		end
		comp_hashes
	end

	def setup_components(hash)
		comps = []
		if component_hash
			component_hash.each { |type, value| comps << Component.new(type) if value }
		end
		comps
	end

end