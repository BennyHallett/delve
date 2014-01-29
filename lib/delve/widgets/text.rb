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

    x = @x
    @text.each_char do |c|
      display.draw x, @y, c
      x += 1
    end
  end
end
