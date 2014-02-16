require 'delve/generator/cellular'
require 'delve/display/curses_renderer'
require 'delve/display/display'

display = Display.new CursesRenderer.new

cellular = CellularGenerator.new 80, 24
cellular.generate do |x, y, value|
  display.draw(x, y, value == 1 ? '#' : '.')
end
display.render

sleep 4

display.exit
