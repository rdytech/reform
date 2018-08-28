module Representable218::Represent
  def represent(represented, array_class=Array)
    return for_collection.prepare(represented) if represented.is_a?(array_class)
    prepare(represented)
  end
end
