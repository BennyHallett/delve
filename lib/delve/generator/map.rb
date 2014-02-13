class Map

  @@default_width = 80
  @@default_height = 24

  def initialize(width=nil, height=nil)
    @width = width || @@default_width
    @height = height || @@default_height
  end

  def width
    @width
  end

  def height
    @height
  end

end
