require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/input/input'
require 'delve/input/curses_input'
require 'delve/widgets/text'

title = TextWidget.new :center, 0, 'Press a character key to continue'
display = Display.new CursesRenderer.new
input = Input.new CursesInput.new
size = TextWidget.new 0, 1, "The console is #{display.width}x#{display.height}."

title.draw display
size.draw display
display.draw(2, 2, '@')
display.draw(4, 6, 'x')
display.render

x = input.wait_for_input

display.draw(5, 4, 'y')
display.draw(3, 3, 'p')
display.draw(0, 0, x)
display.render

sleep 2

display.exit
