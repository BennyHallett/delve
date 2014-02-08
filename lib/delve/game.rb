class Game
  def initialize(display, screen_manager, input)
    raise 'Unable to initialize game when display is nil' unless display
    raise 'Unable to initialize game when screen manager is nil' unless screen_manager
    raise 'Unable to initalize game when input is nil' unless input
    @display = display
    @screen_manager = screen_manager
    @input = input
  end

  def start
    raise 'Unable to start game when screen_manager is empty' if @screen_manager.empty?
    quit = false
    while !quit
      @screen_manager.render @display
      @display.render

      quit = @screen_manager.update @input
    end
  end

end
