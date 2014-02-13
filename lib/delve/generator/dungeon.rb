require 'delve/generator/map'

class Dungeon < Map

  def initialize(width=nil, height=nil)
    super width, height
    @rooms = Array.new
    @corridors = Array.new
  end

  def rooms
    @rooms
  end

  def corridors
    @corridors
  end

end
