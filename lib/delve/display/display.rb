class Display

  def initialize(renderer, options=Hash.new)
    raise 'Cannot initialize display with no renderer' unless renderer
    
    default_options = {
      :width        => 80,
      :height       => 24,
      :background   => :black,
      :foreground   => :white
    }

    @options = default_options
  end

  def options
    return @options
  end

end
