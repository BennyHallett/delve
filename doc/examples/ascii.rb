require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/widgets/multi_line'

art = MultiLineWidget.new 1, 1, [
  'Ascii Art Demo',
  '+-------------------------------------------+',
  '|           |                  |            |',
  '|    |      |         |        |       |    |',
  '|    |                |                |    |',
  '+-------------------------------------------+'
]
display = Display.new CursesRenderer.new

art.draw display
display.render

sleep 4

display.exit
