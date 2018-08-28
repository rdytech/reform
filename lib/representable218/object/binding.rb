module Representable218
  module Object
    class Binding < Representable218::Binding
      def self.build_for(definition, *args)  # TODO: remove default arg.
        return Collection.new(definition, *args)  if definition.array?
        new(definition, *args)
      end

      def read(hash)
        fragment = hash.send(as) # :getter? no, that's for parsing!

        return FragmentNotFound if fragment.nil? and typed?
        fragment
      end

      def write(hash, fragment)
        true
      end

      def deserialize_method
        :from_object
      end

      def serialize_method
        :to_object
      end


      class Collection < self
        include Representable218::Binding::Collection
      end
    end
  end
end