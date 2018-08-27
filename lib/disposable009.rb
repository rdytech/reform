require "disposable009/version"

module Disposable009
  autoload :Twin,         'disposable009/twin'
  autoload :Composition,  'disposable009/composition'
end

# if defined?(ActiveRecord)
#   require 'disposable009/facade/active_record'
# end
