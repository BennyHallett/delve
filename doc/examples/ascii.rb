require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/widgets/multi_line'

@lines = [
  'Ascii Art Demo',
  '+-------------------------------------------+',
  '|           |                  |            |',
  '|    |      |         |        |       |    |',
  '|    |                |                |    |',
  '+-------------------------------------------+'
]

def display_art x, y
  art = MultiLineWidget.new x, y, @lines
  display = Display.new CursesRenderer.new

  art.draw display
  display.render
end

display_art 1, 1
sleep 2

display_art :center, 1
sleep 2

display_art 1, :center
sleep 2

display_art :center, :center
sleep 2

display.exit
