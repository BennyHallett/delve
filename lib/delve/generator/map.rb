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

  def fill(value)
    map = Array.new
    (0..@width-1).each do |x|
      map << Array.new
      (0..@height-1).each do
        map[x] << value
      end
    end
    map
  end

end
