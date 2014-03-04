class ProgressWidget
  attr_accessor :current, :max
  
  def initialize(x, y, width, current, max, fg, bg)
    raise 'Cannot initialize progress widget when x is nil' unless x
    raise 'Cannot initialize progress widget when y is nil' unless y
    raise 'Cannot initialize progress widget when width is nil' unless width 
    raise 'Cannot initialize progress widget when current value is nil' unless current
    raise 'Cannot initialize progress widget when max value is nil' unless max
    raise 'Cannot initialize progress widget when foreground color is nil' unless fg
    raise 'Cannot initialize progress widget when background color is nil' unless bg

    @x = x
    @y = y
    @width = width
    @current = current
    @max = max
    @fg = fg
    @bg = bg
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    percent = 1.0 * @current / @max
    to_fill = (percent * @width).ceil

    x = @x
    (0..@width-1).each do |i|
      color = i < to_fill ? @fg : @bg
      display.draw x, @y, ' ', color, color
      x += 1
    end

  end

end
