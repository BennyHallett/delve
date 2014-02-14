class RogueGenerator < Map

  def initialize(width=nil, height=nil, opts=Hash.new)
    super width, height

    @options = {
      :cell_width => 3,
      :cell_height => 3,
      :room_width => 3,
      :room_height => 3
    }

    opts.keys.each do |key|
      @options[key] = opts[key]
    end
  end

  def create
    @map = fill 1
    @rooms = Array.new
    @connected_cells = Array.new

    init_rooms
    connect_rooms
    connect_unconnected_rooms
    create_rooms
    create_corridors

    if block_given?
      (0..@map.length-1).each do |x|
        (0..@map[0].length-1).each do |y|
          yield x, y, @map[x][y]
        end
      end
    end
  end

  private
  def random_int(min, max)
    (rand * (max - min + 1)).floor + min
  end

  def calculate_room_size(size, cell)
    max = ((size/cell) * 0.8).floor
    min = ((size/cell) * 0.25).floor
    min = 2 if min < 2
    max = 2 if max < 2
    [min, max]
  end

  def init_rooms
    (0..@options[:cell_width]-1).each do |i|
      @rooms << Array.new
      (0..@options[:cell_height]-1).each do |j|
        @rooms[i] << {
          :x => 0,
          :y => 0,
          :width => 0,
          :height => 0,
          :connections => Array.new,
          :cell_x => i,
          :cell_y => j
        }
      end
    end
  end

  def connect_rooms
    cgx = random_int 0, @options[:cell_width]-1
    cgy = random_int 0, @options[:cell_height]-1

    found = false

    loop do

      dir_to_check = [0, 2, 4, 6]
      
      loop do
        found = false
        idx = dir_to_check.sample
        dir_to_check.remove idx

        new_cgx = determine_ncgx(idx)
        ncgx = cgx + new_cgx[:x]
        ncgy = cgx + new_cgx[:y]

        room = @rooms[cgx][xgy]

        if room[:connections].length > 0
          if room[:connections][0][0] == ncgx and room[:connections][0][1] == ncgy
            break
          end
        end

        other_room = this.rooms[ncgx][ncgy]

        if other_room[:connections].length == 0
          other_room[:connections] << [cgx, cgy]

          @connected_cells << [ncgx, ncgy]
          cgx = ncgx
          cgy = ncgy
          found = true
        end

        break if dir_to_check.length < 0 or found
      end

      break if dir_to_check.length < 0
    end
  end

  def determine_ncgx(idx)
    return { :x => 0, :y => -1 } if idx == 0
    return { :x => 1, :y => 0 } if idx == 2
    return { :x => 0, :y => 1 } if idx == 4
    return { :x => -1, :y => 0 } if idx == 6
    raise "Error determining ncgx with #{idx}."
  end

  def connect_unconnected_rooms
    cw = @options[:cell_width]
    ch = @options[:cell_height]

    (0..@options[:cell_width]-1).each do |i|
      (0..@options[:cell_height]-1).each do |j|
        room = @rooms[i][j]

        if room[:connections].length == 0
          directions = [0, 2, 4, 6]
          valid_room = false

          loop do

            dir_idx = directions.sample
            directions.remove dir_idx

            ncgx = determine_ncgx
            new_i = i + ncgx[:x]
            new_j = j + ncgx[:y]

            if new_i < 0 or new_i >= cw or new_j < 0 or new_j >= ch
              next
            end

            other_room = @rooms[:new_i][:new_j]

            valid_room = true

            if other_room[:connections].length == 0
              break
            end

            (0..other_room[:connections].length-1).each do |k|
              if other_room[:connections][k][0] == i and other_room[:connections][k][1] == j
                valid_room = false
                break
              end
            end

            break if valid_room
            break if directions.length == 0
          end

          room[:connections] << [other_room[:cell_x], other_room[:cell_y]] if valid_room
        end
      end
    end
  end

  def create_rooms

  end

















end
