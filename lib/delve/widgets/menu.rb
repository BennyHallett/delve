class MenuWidget
  def initialize(x, y, items)
    raise 'Cannot initialize menu widget when x is nil' unless x
    raise 'Cannot initialize menu widget when y is nil' unless y
    raise 'Cannot initialize menu widget when items is nil' unless items
    raise 'Cannot initialize menu widget when items is empty' if items.empty?

    @x = x
    @y = y
    @items = items
    @selected_index = 0
  end

  def selected_item
    key = @items.keys[@selected_index]
    @items[key]
  end

  def next
    @selected_index += 1
  end

  def previous
    @selected_index -= 1
  end

  def draw(display)
    raise 'Cannot draw text when display is nil' unless display
  end
end
