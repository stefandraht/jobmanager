require 'rspec'
require_relative '../lib/application/components'

shared_examples_for "ComponentModule" do

	subject { component }

	it { should respond_to :execute }

end

class DummyClass
end

describe "DesignServer" do
	let(:component) { DummyClass.new.extend(DesignServer) }
	it_behaves_like "ComponentModule"
end

describe "EditServer" do
	let(:component) { DummyClass.new.extend(EditServer) }
	it_behaves_like "ComponentModule"
end