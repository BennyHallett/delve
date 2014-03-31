require 'delve/path/path'

class AStar < Path

  def initialize(to_x, to_y, free_checker, options = Hash.new)
    super to_x, to_y, free_checker, options

    @todo = Array.new
    @done = Hash.new
    @from_x = nil
    @from_y = nil
  end

  def compute(from_x, from_y)
    raise 'Cannot compute path without a block' unless block_given?

    @todo = Array.new
    @done = Hash.new
    @from_x = from_x
    @from_y = from_y
    add @to_x, @to_y, nil

    while @todo.length > 0
      item = @todo.shift
      break if item.x == from_x and item.y = from_y
      neighbours = get_neighbours item.x, item.y

      (0..neighbours.length-1).each do |i|
        neighbour = neighbours[i]
        x = neighbour[0]
        y = neighbour[1]
        id = "#{x},#{y}"
        next if @done.include? id
        add x, y, item
      end
    end

    item = @done["#{from_x},#{from_y}"]
    return nil if item.nil?

    until item.nil?
      yield item.x, item.y
      item = item.prev
    end
  end

  private
  def add(x, y, prev)
    #TODO: Up to here
  end

end
