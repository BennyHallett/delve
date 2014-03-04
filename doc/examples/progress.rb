require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/widgets/progress'

display = Display.new CursesRenderer.new
progress = ProgressWidget.new 3, 3, 20, 10, 10, :green, :white

progress.draw display
display.render

sleep 2

progress.current = 5
progress.draw display
display.render

sleep 2

progress.current = 2
progress.draw display
display.render

sleep 2

display.exit
