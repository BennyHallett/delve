class FieldOfView

  def initialize(options=Hash.new, block&)
    @light_passes = block&
    @options = { :topology => 8 }
    options.each { |k, v| @options[k] = v }
  end

  def compute(x, y, r, block&)

  end

  private
  def get_circle(cx, cy, r)
    
  end

end
