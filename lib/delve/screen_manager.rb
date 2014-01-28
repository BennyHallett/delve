class ScreenManager
  def initialize
    @screen_stack = Array.new
  end

  def empty?
    @screen_stack.empty?
  end
end
