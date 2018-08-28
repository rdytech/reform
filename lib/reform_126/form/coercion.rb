require 'representable218/coercion'

module Reform126::Form::Coercion
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:register_feature, self)
  end

  module ClassMethods
    def representer_class # TODO: check out how we can utilise Config#features.
      super.class_eval do
        include Representable218::Coercion
        self
      end
    end
  end
end
