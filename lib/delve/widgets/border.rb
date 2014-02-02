class BorderWidget
  def initialize(x, y, width, height, heading=nil, fg=:white, bg=:black, corners=true)
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
    @corners = corners
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    header_text = " #{@heading} "
    if header_text.length.odd?
      header_text = "#{header_text} "
    end
    center_point = ((@x + @width) / 2).floor
    half_text = (header_text.length / 2).ceil
    header_start = center_point - half_text
    header_end = center_point + half_text
    
    (@x..(@x+@width-1)).each do |x|
      char = (x == @x || x == (@x+@width-1)) ? '+' : '-'
      if @heading and x > header_start and x <= header_end
        char = header_text[x-header_start-1]
      end
      if char == '-' or @corners 
        display.draw x, @y, char, @fg, @bg
        display.draw x, (@y+@height-1), (x == @x || x == (@x+@width-1)) ? '+' : '-', @fg, @bg
      end
    end

    ((@y+1)..(@y+@height-2)).each do |y|
      display.draw @x, y, '|', @fg, @bg
      display.draw (@x+@width-1), y, '|', @fg, @bg
    end
  end
end
