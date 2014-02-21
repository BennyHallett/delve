require 'delve/generator/rogue'
require 'delve/display/curses_renderer'
require 'delve/display/display'

display = Display.new CursesRenderer.new

rogue = RogueGenerator.new 100, 40
rogue.generate do |x, y, value|
  display.draw(x, y, value == 1 ? '#' : '.')
end
display.render

sleep 4

display.exit
