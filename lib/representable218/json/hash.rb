require 'representable218/json'
require 'representable218/hash_methods'

module Representable218::JSON
  # "Lonely Hash" support.
  module Hash
    def self.included(base)
      base.class_eval do
        include Representable218
        extend ClassMethods
        include Representable218::JSON
        include Representable218::HashMethods
        representable_attrs.add(:_self, {:hash => true})
      end
    end


    module ClassMethods
      def values(options, &block)
        hash(:_self, options, &block)
      end
    end
  end
end
