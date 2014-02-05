class TextWidget
  def initialize(x, y, text)
    raise 'Cannot initialize text widget when x is nil' unless x
    raise 'Cannot initialize text widget when y is nil' unless y
    raise 'Cannot initialize text widget when text is nil' unless text

    @x = x
    @y = y
    @text = text
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    x = determine_x(display)
    y = determine_y(display)
    @text.each_char do |c|
      display.draw x, y, c
      x += 1
    end
  end

  private
  def determine_x display
    if @x == :center
      return (display.width / 2.0).ceil - (@text.length / 2.0).floor
    end
    @x
  end

  def determine_y display
    if @y == :center
      return ((display.height / 2.0).ceil)
    end
    @y
  end
end
