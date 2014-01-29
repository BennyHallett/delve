require 'delve/display/display'
require 'delve/display/curses_renderer'

display = Display.new CursesRenderer.new

display.draw(2, 2, '@')
display.draw(4, 6, 'x')
display.render

x = display.wait_for_input

display.draw(5, 1, 'y')
display.draw(3, 3, 'p')
display.draw(0, 0, x)
display.render

sleep 2

display.exit
