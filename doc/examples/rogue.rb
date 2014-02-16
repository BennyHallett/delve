require 'delve/generator/rogue'
require 'delve/display/curses_renderer'
require 'delve/display/display'

display = Display.new CursesRenderer.new

rogue = RogueGenerator.new 10, 10
rogue.generate do |x, y, value|
  display.draw(x, y, value)
end
display.render

sleep 4

display.exit
