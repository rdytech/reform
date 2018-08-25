module Reform126
  def self.rails3_0?
    ::ActiveModel::VERSION::MAJOR == 3 and ::ActiveModel::VERSION::MINOR == 0
  end
end

require 'reform_126/contract'
require 'reform_126/form'
require 'reform_126/form/composition'
require 'reform_126/form/active_model'
require 'reform_126/form/module'
require 'reform_126/composition'


if defined?(Rails) # DISCUSS: is everyone ok with this?
  require 'reform_126/rails'
end
