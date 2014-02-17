class ViewportWidget
  def initialize(x, y, width, height, world)
    raise 'Cannot initialize text widget when x is nil' unless x
    raise 'Cannot initialize text widget when y is nil' unless y
    raise 'Cannot initialize text widget when width is nil' unless width
    raise 'Cannot initialize text widget when height is nil' unless height
    raise 'Cannot initialize text widget when text is nil' unless world

    @x = x
    @y = y
    @width = width
    @height = height
    @world = world
  end

  def focus(x, y)
    raise 'Cannot focus viewport out of world' if x < 0 || y < 0 || x >= @world.width || y >= @world.height
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

  end
end
