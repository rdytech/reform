module Reform126::Form::Changed
  def changed?(name=nil)
    !! changed[name.to_s]
  end

  def changed
    @changed ||= {}
  end
end