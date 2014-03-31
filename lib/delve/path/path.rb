class Path

  @@default_options = { topology: :eight }
  
  def initialize(to_x, to_y, free_checker, options = Hash.new)
    raise 'Cannot initialize path if to_x is nil' if to_x.nil?
    raise 'Cannot initialize path if to_y is nil' if to_y.nil?
    raise 'Cannot initialize path if free checker is nil' if free_checker.nil?
    raise 'Cannot initialize path if free checker does not respond to #free?' unless free_checker.respond_to? :free?

    @to_x = to_x
    @to_y = to_y
    @from_x = nil
    @from_y = nil
    @free_checker = free_checker
    @options = @@default_options.merge options

    @dirs = directions(options[:topology])
  end

  def compute(from_x, from_y)
  end

  private
  def get_neighbours(cx, cy)
    result = Array.new
    (0..@dirs.length-1).each do |i|
      dir = @dirs[i]
      x = cx + dir[0]
      y = cy + dir[1]

      next unless @free_checker.free? x, y
      result << [x, y]
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
