class MenuWidget
  def initialize(x, y, items, foreground=:white, background=:black, highlight=:red)
    raise 'Cannot initialize menu widget when x is nil' unless x
    raise 'Cannot initialize menu widget when y is nil' unless y
    raise 'Cannot initialize menu widget when items is nil' unless items
    raise 'Cannot initialize menu widget when items is empty' if items.empty?

    @x = x
    @y = y
    @items = items
    @selected_index = 0
    @fg = foreground
    @bg = background
    @highlight = highlight
  end

  def selected_item
    key = @items.keys[@selected_index]
    @items[key]
  end

  def next
    @selected_index += 1
    if @selected_index >= @items.keys.length
      @selected_index = 0
    end
  end

  def previous
    @selected_index -= 1
    if @selected_index < 0
      @selected_index = @items.keys.length - 1
    end
  end

  def select(key)
    return false if !@items.keys.include? key
    @selected_index = @items.keys.index key
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display

    items = 0
    @items.keys.each do |key|
      chars = 0
      y = determine_y display
      @items[key].each_char do |c|
        fg = @selected_index == items ? @bg : @fg
        bg = @selected_index == items ? @fg : @bg
        x = determine_x display
        text_color = (c == key || c == key.upcase) ? @highlight : fg
        display.draw(x + chars, y + items, c, text_color, bg)
        chars += 1
      end
      items += 1
    end
  end

  private
  def determine_x display
    if @x == :center
      return (display.width / 2.0).ceil - (longest_line / 2.0).floor
    end
    @x
  end

  def determine_y display
    if @y == :center
      return ((display.height / 2.0).ceil) - (@items.keys.length / 2.0).floor
    end
    @y
  end

  def longest_line
    value = -1
    @items.keys.each do |key|
      if value < @items[key].length
        value = @items[key].length
      end
    end
    return value
  end
end
