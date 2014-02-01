require 'delve/generator/noise'
require 'delve/display/curses_renderer'
require 'delve/display/display'

display = Display.new CursesRenderer.new

def generate_noise(grain, d)
  noise = Noise.new 96, 32, grain
  noise.generate do |x, y, value|
    v = (value * 10).floor
    t = '.'
    t = '^' if v < 9
    t = 'M' if v < 7
    t = '.' if v < 5
    t = 'w' if v < 3
    t = 'W' if v < 1

    d.draw(x, y, t)
  end
end

generate_noise :fine, display
display.render
sleep 2

generate_noise :coarse, display
display.render
sleep 2

display.exit
