require 'representable218/xml'
require 'representable218/hash_methods'

module Representable218::XML
  module AttributeHash
    include Representable218::XML
    include Representable218::HashMethods

    def self.included(base)
      base.class_eval do
        include Representable218
        extend ClassMethods
        representable_attrs.add(:_self, {:hash => true, :use_attributes => true})
      end
    end


    module ClassMethods
      def values(options)
        hash :_self, options.merge!(:use_attributes => true)
      end
    end
  end

  module Hash
    include Representable218::XML
    include HashMethods

    def self.included(base)
      base.class_eval do
        include Representable218
        extend ClassMethods
        representable_attrs.add(:_self, {:hash => true})
      end
    end


    module ClassMethods
      def values(options)
        hash :_self, options
      end
    end
  end
end
