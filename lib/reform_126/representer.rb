require 'representable218/hash'
require 'representable218/decorator'

module Reform126
  class Representer < Representable218::Decorator
    include Representable218::Hash::AllowSymbols

    extend Uber::InheritableAttr
    inheritable_attr :options # FIXME: this doesn't need to be inheritable.
    # self.options = {}


    class Options < ::Hash
      def include!(names)
        includes.push(*names) #if names.size > 0
        self
      end

      def exclude!(names)
        excludes.push(*names) #if names.size > 0
        self
      end

      def excludes
        self[:exclude] ||= []
      end

      def includes
        self[:include] ||= []
      end
    end


    include Representable218::Hash

    # Returns hash of all property names.
    def self.fields(&block)
      representable_attrs.find_all(&block).map(&:name)
    end

    def self.each(only_form=true, &block)
      definitions = representable_attrs
      definitions = representable_attrs.find_all { |attr| attr[:form] } if only_form

      definitions.each(&block)
      self
    end

    def self.for(options)
      clone.tap do |representer|
        representer.options = options
      end
    end

    def self.default_inline_class
      options[:form_class]
    end

    def self.clone # called in inheritable_attr :representer_class.
      Class.new(self) # By subclassing, representable_attrs.clone is called.
    end

  private

    # Inline forms always get saved in :extend.
    def self.build_inline(base, features, name, options, &block)
      name = name.to_s.singularize.camelize

      features = options[:features]

      Class.new(base || default_inline_class) do
        include *features

        class_eval &block

        @form_name = name

        def self.name # needed by ActiveModel::Validation and I18N.
          @form_name
        end
      end
    end
  end
end