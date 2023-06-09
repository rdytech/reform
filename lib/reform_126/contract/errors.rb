# The Errors class is planned to replace AM::Errors. It provides proper nested error messages.
class Reform126::Contract::Errors < ActiveModel::Errors
  def messages
    return super unless Reform126.rails3_0?
    self
  end

  # def each
  #   messages.each_key do |attribute|
  #     self[attribute].each { |error| yield attribute, Array.wrap(error) }
  #   end
  # end

  def merge!(errors, prefix)
    rails6_0_merge(errors, prefix)
  end

  def rails6_0_merge(errors, prefix)
    # TODO: merge into AM.
    errors.messages.each do |field, msgs|
      unless field.to_sym == :base
        field = (prefix+[field]).join(".").to_sym # TODO: why is that a symbol in Rails?
      end

      msgs = [msgs] if Reform126.rails3_0? # DISCUSS: fix in #each?

      msgs.each do |msg|
        next if messages[field] and messages[field].include?(msg)
        add(field, msg)
      end # Forms now contains a plain errors hash. the errors for each item are still available in item.errors.
    end
  end

  def valid? # TODO: test me in unit test.
    blank?
  end

  def to_s
    messages.inspect
  end
end # Errors
