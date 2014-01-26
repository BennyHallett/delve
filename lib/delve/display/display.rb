class Display

  def initialize(renderer, options=Hash.new)
    raise 'Cannot initialize display with no renderer' unless renderer
   
    @renderer = renderer
 
    default_options = {
      :width        => 80,
      :height       => 24,
      :background   => :black,
      :foreground   => :white
    }

    options.keys.each { |k| default_options[k] = options[k] }
    @options = default_options
  end

  def options
    return @options
  end

end
