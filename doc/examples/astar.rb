require 'delve/display/display'
require 'delve/display/curses_renderer'
require 'delve/path/astar'

class World 

  def free?(x, y)
    true
  end

end

display = Display.new CursesRenderer.new
colours = []

(0..5).each do |x|
  colours << []
  (0..5).each do |y|
    colours[x] << :white
  end
end

world = World.new
path = AStar.new 3, 4, world, { topology: :four }
path.compute(1,  2) do |x, y|
  colours[x][y] = :red
end

(0..5).each do |x|
  (0..5).each do |y|
    display.draw x, y, 'o', colours[x][y], :black
  end
end

display.render

sleep 2

display.exit
