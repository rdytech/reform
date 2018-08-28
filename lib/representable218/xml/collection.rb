module Representable218::XML
  module Collection
    include Representable218::XML

    def self.included(base)
      base.send :include, Representable218::XML
      base.send :include, Representable218::Hash::Collection
      base.send :include, Methods
    end


    module Methods
      def update_properties_from(doc, *args)
        super(doc.search("./*"), *args) # pass the list of collection items to Hash::Collection#update_properties_from.
      end
    end
  end
end
