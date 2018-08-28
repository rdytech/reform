require 'rep_test_helper'

class BindingTest < MiniTest::Spec
  Binding = Representable218::Binding
  let (:render_nil_definition) { Representable218::Definition.new(:song, :render_nil => true) }

  describe "#skipable_empty_value?" do
    let (:binding) { Binding.new(render_nil_definition, nil, nil) }

    # don't skip when present.
    it { binding.skipable_empty_value?("Disconnect, Disconnect").must_equal false }

    # don't skip when it's nil and render_nil: true
    it { binding.skipable_empty_value?(nil).must_equal false }

    # skip when nil and :render_nil undefined.
    it { Binding.new(Representable218::Definition.new(:song), nil, nil).skipable_empty_value?(nil).must_equal true }

    # don't skip when nil and :render_nil undefined.
    it { Binding.new(Representable218::Definition.new(:song), nil, nil).skipable_empty_value?("Fatal Flu").must_equal false }
  end


  describe "#default_for" do
    let (:definition) { Representable218::Definition.new(:song, :default => "Insider") }
    let (:binding) { Binding.new(definition, nil, nil) }

    # return value when value present.
    it { binding.default_for("Black And Blue").must_equal "Black And Blue" }

    # return false when value false.
    it { binding.default_for(false).must_equal false }

    # return default when value nil.
    it { binding.default_for(nil).must_equal "Insider" }

    # return nil when value nil and render_nil: true.
    it { Binding.new(render_nil_definition, nil, nil).default_for(nil).must_equal nil }

    # return nil when value nil and render_nil: true, even when :default is set" do
    it { Binding.new(Representable218::Definition.new(:song, :render_nil => true, :default => "The Quest"), nil, nil).default_for(nil).must_equal nil }

    # return nil if no :default
    it { Binding.new(Representable218::Definition.new(:song), nil, nil).default_for(nil).must_equal nil }
  end
end