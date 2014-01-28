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
end
