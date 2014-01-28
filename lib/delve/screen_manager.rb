class ScreenManager
  def initialize
    @screen_stack = Array.new
  end

  def empty?
    @screen_stack.empty?
  end

  def push_screen(screen)
    @screen_stack.push screen
  end

  def pop_screen
    @screen_stack.pop
  end

  def handle_key(key)
    raise 'Cannot handle key when no screens are present' if empty?
    @screen_stack.last.handle_key(key)
  end

  def render(display)
    raise 'Cannot render when no screens are present' if empty?
    raise 'Cannot render when display is nil' unless display

    bottom = @screen_stack.length - 1
    screens = @screen_stack.length - 1
    
    (0..screens).reverse_each do |i|
      if !@screen_stack[i].partial?
        break
      end
      bottom = i-1
    end
    (bottom..screens).each do |i|
      @screen_stack[i].render display
    end
  end
end
