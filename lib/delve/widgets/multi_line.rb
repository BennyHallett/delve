class MultiLineWidget
  def initialize(x, y, lines)
    raise 'Cannot initialize text widget when x is nil' unless x
    raise 'Cannot initialize text widget when y is nil' unless y
    raise 'Cannot initialize text widget when lines is nil' unless lines

    @x = x
    @y = y
    @lines = lines
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    y = @y
    @lines.each do |line|
      x = @x
      line.each_char do |c|
        display.draw x, y, c
        x += 1
      end
      y += 1
    end
  end
end
