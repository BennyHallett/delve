class BorderWidget
  def initialize(x, y, width, height, heading=nil, fg=:white, bg=:black)
    raise 'Cannot initialize border widget when x is nil' unless x
    raise 'Cannot initialize border widget when y is nil' unless y
    raise 'Cannot initailize border widget when width is nil' unless width
    raise 'Cannot initialize border widget when height is nil' unless height
    raise 'Cannot initialize border widget when heading is wider than width + 4' if heading and heading.length > width + 4

    @x = x
    @y = y
    @width = width
    @height = height
    @heading = heading
    @fg = fg
    @bg = bg
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display
  end
end
