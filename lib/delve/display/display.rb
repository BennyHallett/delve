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
    @renderer.init
  end

  def draw(x, y, char, foreground=nil, background=nil)
    fg = foreground || @options[:foreground]
    bg = background || @options[:background]
    @render_data["#{x},#{y}"] = { :x => x, :y => y, :char => char, :foreground => fg, :background => bg }
    @dirty = true
  end

  def options
    return @options
  end

  def render
    @renderer.render @render_data if @dirty
  end

end
