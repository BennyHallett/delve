class KeyValueWidget
  attr_accessor :value
  
  def initialize(x, y, label, value)
    raise 'Cannot initialize key value widget when x is nil' unless x
    raise 'Cannot initialize key value widget when y is nil' unless y
    raise 'Cannot initialize key value widget when label is nil' unless label
    raise 'Cannot initialize key value widget when value is nil' unless value

    @x = x
    @y = y
    @label = label
    @value = value
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    x = @x
    @label.each_char do |c|
      display.draw x, @y, c
      x += 1
    end

    display.draw x, @y, ':'
    x += 1
    display.draw x, @y, ' '
    x += 1

    @value.each_char do |c|
      display.draw x, @y, c
      x += 1
    end
  end

end
