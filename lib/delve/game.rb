class Game
  def initialize(display, screen_manager)
    raise 'Unable to initialize game when display is nil' unless display
    raise 'Unable to initialize game when screen manager is nil' unless screen_manager
    @display = display
    @screen_manager = screen_manager
  end

  def start
    raise 'Unable to start game when screen_manager is empty' if @screen_manager.empty?
    quit = false
    while !quit
      @screen_manager.render @display
      quit = @screen_manager.update
    end
  end

end
