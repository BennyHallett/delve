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
    @screen_stack.last.handle_key(key)
  end
end
