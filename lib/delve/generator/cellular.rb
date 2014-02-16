require 'delve/generator/map'

class CellularGenerator < Map

  def initialize(width=nil, height=nil, opts=Hash.new)
    super width, height
    @options = {
      born: [5, 6, 7, 8],
      survive: [4, 5, 6, 7, 8],
      topology: :eight
    }

    set_options opts

    @dirs = directions @options[:topology]
    @map = fill 0
  end

  def randomize(probablility)
    (0..@width-1).each do |i|
      (0..@height-1).each do |j|
        @map[i][j] = rand < probablility ? 1 : 0
      end
    end
  end

  def set_options(opts)
    opts.keys.each { |key| @options[key] = opts[key] }
  end

  def set(x, y, value)
    @map[x][y] = value
  end

  def generate
    new_map = fill 0
    born = @options[:born]
    survive = @options[:survive]

    (0..@height-1).each do |j|
      width_step = 1
      width_start = 0
      if @options[:topology] == 6
        width_step = 2
        width_start = j%2
      end

      width_start.step(@width-1, width_step) do |i|
        curr = @map[i][j]
        ncount = get_neighbours i, j

        if curr > 0 and survive.index(ncount) != -1
          new_map[i][j] = 1
        elsif curr <= 0 and born.index(ncount) != -1
          new_map[i][j] = 1
        end

        yield i, j, new_map[i][j]
      end
    end

    @map = new_map
  end

  private
  def get_neighbours cx, cy
    result = 0
    (0..@dirs.length - 1).each do |i|
      dir = @dirs[i]
      x = cx + dir[0]
      y = cy + dir[1]
      
      next if x < 0 or x >= @width or y < 0 or y >= @height
      result += @map[x][y] == 1 ? 1 :0
    end

    result
  end

  def directions(v)
    dirs = {
      :four => [
        [ 0, -1],
        [ 1,  0],
        [ 0,  1],
        [-1,  0]
      ],
      :eight => [
        [ 0, -1],
        [ 1, -1],
        [ 1,  0],
        [ 1,  1],
        [ 0,  1],
        [-1,  1],
        [-1,  0],
        [-1, -1]
      ],
      :six => [
        [-1, -1],
        [ 1, -1],
        [ 2,  0],
        [ 1,  1],
        [-1,  1],
        [-2,  0]
      ]
    }

    dirs[v]
  end

end
