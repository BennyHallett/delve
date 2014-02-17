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
    @rx = 0
    @ry = 0
  end

  def focus(x, y)
    raise 'Cannot focus viewport out of world' if x < 0 || y < 0 || x >= @world.width || y >= @world.height

    @rx = x - (@width/2).floor
    @ry = y - (@height/2).floor

    @rx = 0 if @rx < 0
    @ry = 0 if @ry < 0
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    dx = 0
    (@x..(@x+@width-1)).each do |x|
      dy = 0
      (@y..(@y+@height-1)).each do |y|
        display.draw x, y, @world.at(@rx+dx, @ry+dy)
        dy += 1
      end
      dx += 1
    end
  end
end
