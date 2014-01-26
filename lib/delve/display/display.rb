class Display

  def initialize(renderer, options=Hash.new)
    raise 'Cannot initialize display with no renderer' unless renderer
   
    @renderer = renderer
    @dirty = false
    @render_data = Hash.new
 
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

  def render
    @renderer.render @render_data if @dirty
  end

end
