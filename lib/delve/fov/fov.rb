class FieldOfView

  def initialize(options=Hash.new, block&)
    @light_passes = block&
    @options = { :topology => :eight }
    options.each { |k, v| @options[k] = v }
  end

  def compute(x, y, r, block&)

  end

  private
  def get_circle(cx, cy, r)
    result = Array.new
    dirs, count_factor, start_offset = nil

    if @options[:topology] == :four
      count_factor = 1
      start_offset = [0, 1]
      dirs = [
        directions[:eight][7],
        directions[:eight][1],
        directions[:eight][3],
        directions[:eight][5]
      ]
    elsif @options[:topology] == :six
      dirs = directions[:six]
      count_factor = 1
      start_offset = [-1, 1]
    elsif @options[:topology] == :eight
      dirs = directions[:four]
      count_factor = 2
      start_offset = [-1, 1]
    end

    x = cx + (start_offset[0] * r)
    y = cy + (start_offset[1] * r)

    (0..dirs.length-1).each do |i|
      (0..((r*count_factor) - 1)).each do |j|
        result << [x, y]
        x += dirs[i][0]
        y += dirs[i][1]
      end
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
