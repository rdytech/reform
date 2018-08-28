module Representable218::JSON
  module Collection
    include Representable218::JSON

    def self.included(base)
      base.send :include, Representable218::Hash::Collection
    end
  end
end
