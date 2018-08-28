require 'representable218/json'

module Reform126
  module Form::JSON
    def self.included(base)
      base.representer_class.send :include, Representable218::JSON
    end

    def deserialize_method
      :from_json
    end
  end
end
