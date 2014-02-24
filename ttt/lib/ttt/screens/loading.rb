require 'delve/widgets/text'
require 'delve/generator/rogue'

require 'ttt/world'
require 'ttt/factory/player'
require 'ttt/screens/game'

class LoadingScreen

  def initialize(screen_manager)
    @manager = screen_manager
    @text = TextWidget.new :center, :center, 'Creating world (this may take a while)'
    @player_factory = PlayerFactory.new
  end

  def render(display)
    @text.draw display
  end

  def partial?
    false
  end

  def update(input)
    world = World.new(RogueGenerator.new(256, 128))
    player = @player_factory.create
    @manager.push_screen GameScreen.new(world, player, @manager)
    false
  end

end
