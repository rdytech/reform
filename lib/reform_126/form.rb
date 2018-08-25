module Reform126
  class Form < Contract
    self.representer_class = Reform126::Representer.for(:form_class => self)

    require "reform_126/form/validate"
    include Validate # extend Contract#validate with additional behaviour.
    require "reform_126/form/sync"
    include Sync
    require "reform_126/form/save"
    include Save
    require "reform_126/form/prepopulate"
    include Prepopulate

    require "reform_126/form/multi_parameter_attributes"
    include MultiParameterAttributes # TODO: make features dynamic.

  private
    def aliased_model
      # TODO: cache the Expose.from class!
      Reform126::Expose.from(mapper).new(:model => model)
    end


    require "reform_126/form/scalar"
    extend Scalar::Property # experimental feature!


    # DISCUSS: should that be optional? hooks into #validate, too.
    require "reform_126/form/changed"
    register_feature Changed
    include Changed
  end
end
