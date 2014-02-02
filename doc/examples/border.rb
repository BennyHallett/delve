require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/widgets/border'

display = Display.new CursesRenderer.new
border = BorderWidget.new 0, 0, display.width, display.height, 'This is a border!!', :green, :black, false

border.draw display
display.render

sleep 4

display.exit
