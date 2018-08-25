require 'reform_126/form/active_model'

require 'reform_126/active_record' if defined?(ActiveRecord)

Reform126::Form.class_eval do # DISCUSS: i'd prefer having a separate Rails module to be mixed into the Form but this is way more convenient for 99% users.
  include Reform126::Form::ActiveModel
  include Reform126::Form::ActiveModel::FormBuilderMethods
  include Reform126::Form::ActiveRecord if defined?(ActiveRecord)
end