module Reform126::Form::ActiveRecord
  def self.included(base)
    base.class_eval do
      register_feature Reform126::Form::ActiveRecord
      include Reform126::Form::ActiveModel
      extend ClassMethods
    end
  end

  module ClassMethods
    def validates_uniqueness_of(attribute, options={})
      options = options.merge(:attributes => [attribute])
      validates_with(UniquenessValidator, options)
    end
    def i18n_scope
      :activerecord
    end
  end

  class UniquenessValidator < ::ActiveRecord::Validations::UniquenessValidator
    # when calling validates it should create the Vali instance already and set @klass there! # TODO: fix this in AM.
    def validate(form)
      property = attributes.first

      # here is the thing: why does AM::UniquenessValidator require a filled-out record to work properly? also, why do we need to set
      # the class? it would be way easier to pass #validate a hash of attributes and get back an errors hash.
      # the class for the finder could either be infered from the record or set in the validator instance itself in the call to ::validates.
      record = form.model_for_property(property)
      record.send("#{property}=", form.send(property))

      @klass = record.class # this is usually done in the super-sucky #setup method.
      super(record).tap do |res|
        if record.errors.any?
          if Rails.version > "6.0"
            record.errors.each do |error|
              form.errors.add(property, error.type, error.options)
            end
          else
            form.errors.add(property, record.errors.first.last)
          end
        end
      end
    end
  end

  # TODO: this is no AR thing.
  def model_for_property(name)
    return model unless is_a?(Reform126::Form::Composition) # i am too lazy for proper inheritance. there should be a ActiveRecord::Composition that handles this.

    model_name = mapper.representable_attrs.get(name)[:on]
    model[model_name]
  end
end
