require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/input/input'
require 'delve/input/curses_input'
require 'delve/widgets/menu'

display = Display.new CursesRenderer.new
input = Input.new CursesInput.new
menu = MenuWidget.new :center, 1, { 'f' => 'First item', 's' => 'Second item', 'd' => 'Third item' }

menu.draw display
display.render

x = input.wait_for_input
menu.select x

menu.draw display
display.render

sleep 2

display.exit
