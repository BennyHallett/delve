class Game
  def initialize(display, screen_manager)
    raise 'Unable to initialize game when display is nil' unless display
    raise 'Unable to initialize game when screen manager is nil' unless screen_manager
    @display = display
    @screen_manager = screen_manager
  end

end
