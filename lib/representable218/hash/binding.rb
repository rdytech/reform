require 'representable218/binding'

module Representable218
  module Hash
    class Binding < Representable218::Binding
      def self.build_for(definition, *args)  # TODO: remove default arg.
        return Collection.new(definition, *args)  if definition.array?
        return Hash.new(definition, *args)        if definition.hash?
        new(definition, *args)
      end

      def read(hash)
        return FragmentNotFound unless hash.has_key?(as) # DISCUSS: put it all in #read for performance. not really sure if i like returning that special thing.

        hash[as] # fragment
      end

      def write(hash, fragment)
        hash[as] = fragment
      end

      def serialize_method
        :to_hash
      end

      def deserialize_method
        :from_hash
      end

      class Collection < self
        include Representable218::Binding::Collection
      end


      class Hash < self
        include Representable218::Binding::Hash
      end
    end
  end
end
