require 'delve/generator/map'

class RogueGenerator < Map

  def initialize(width=nil, height=nil, opts=Hash.new)
    super width, height

    @options = {
      :cell_width => 3,
      :cell_height => 3,
    }

    opts.keys.each do |key|
      @options[key] = opts[key]
    end

    @options[:room_width] ||= calculate_room_size width, @options[:cell_width]
    @options[:room_height] ||= calculate_room_size height, @options[:cell_height]
  end

  def generate
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
        break if idx.nil?
        dir_to_check.delete idx

        new_cgx = determine_ncgx(idx)
        ncgx = cgx + new_cgx[:x]
        ncgy = cgx + new_cgx[:y]

        next if ncgx < 0 or ncgx >= @options[:cell_width]-1
        next if ncgy < 0 or ncgy >= @options[:cell_height]-1

        room = @rooms[cgx][cgy]

        if room[:connections].length > 0
          if room[:connections][0][0] == ncgx and room[:connections][0][1] == ncgy
            break
          end
        end

        begin
          other_room = @rooms[ncgx][ncgy]
        rescue
          raise "ncgx: #{ncgx}, ncgy: #{ncgy}, rooms: #{@rooms.length}"
        end

        if other_room and other_room[:connections].length == 0
          other_room[:connections] << [cgx, cgy]

          @connected_cells << [ncgx, ncgy]
          cgx = ncgx
          cgy = ncgy
          found = true
        end

        break if dir_to_check.length <= 0 || found
      end

      break if dir_to_check.length <= 0
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
          other_room = nil

          loop do

            dir_idx = directions.sample
            break if dir_idx.nil?
            directions.delete dir_idx

            ncgx = determine_ncgx dir_idx
            new_i = i + ncgx[:x]
            new_j = j + ncgx[:y]

            if new_i < 0 or new_i >= cw or new_j < 0 or new_j >= ch
              next
            end

            other_room = @rooms[new_i][new_j]

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
    w = @width
    h = @height

    cw = @options[:cell_width]
    ch = @options[:cell_height]

    cwp = (w / cw).floor
    chp = (h / ch).floor

    roomw, roomh, sx, sy, tx, ty, other_room = nil

    room_width = @options[:room_width]
    room_height = @options[:room_height]

    (0..cw-1).each do |i|
      (0..ch-1).each do |j|
        sx = cwp * i
        sy = chp * j

        sx = 1 if sx == 0
        sy = 1 if sy == 0

        roomw = random_int room_width[0], room_width[1]
        roomh = random_int room_height[0], room_height[1]

        if j > 0
          other_room = @rooms[i][j-1]
          while (sy - (other_room[:y] + other_room[:height]) < 3)
            sy += 1
          end
        end
        if i > 0
          other_room = @rooms[i-1][j]
          while (sx - (other_room[:x] + other_room[:width]) < 3)
            sx += 1
          end
        end

        sx_offset = ((random_int 0, cwp-roomw) / 2).round
        sy_offset = ((random_int 0, chp-roomh) / 2).round

        while sx + sx_offset + roomw >= w
          if sx_offset > 0
            sx_offset -= 1
          else
            roomw -= 1
          end
        end

        while sy + sy_offset + roomh >= h
          if sy_offset > 0
            sy_offset -= 1
          else
            roomh -= 1
          end
        end

        sx = sx + sx_offset
        sy = sy + sy_offset

        @rooms[i][j][:x] = sx
        @rooms[i][j][:y] = sy
        @rooms[i][j][:width] = roomw
        @rooms[i][j][:height] = roomh

        (sx..sx + roomw - 1).each do |ii|
          (sy..sy + roomh - 1).each do |jj|
            @map[ii][jj] = 0
          end
        end
      end
    end
  end

  def get_wall_position(room, direction)
    rx = nil
    ry = nil
    door = nil

    if direction == 1 || direction == 3
      rx = random_int(room[:x] + 1, room[:x] + room[:width] - 2)
      if direction == 1
        ry = room[:y] - 2
        door = ry + 1
      else
        ry = room[:y] + room[:height] + 1
        door = ry - 1
      end

      @map[rx][door] = 2 
    elsif direction == 2 || direction == 4
      ry = random_int(room[:y] + 1, room[:y] + room[:height] - 2)
      if direction == 2
        rx = room[:x] + room[:width] + 1
        door = rx - 1
      else
        rx = room[:x] - 2
        door = rx + 1
      end

      @map[door][ry] = 2
    end

    [rx, ry]
  end

  def draw_corridor(start_pos, end_pos)
    x_offset = end_pos[0] - start_pos[0]
    y_offset = end_pos[1] - start_pos[1]

    xpos = start_pos[0]
    ypos = start_pos[1]

    temp_dist, xdir, ydir = nil

    move = nil
    moves = Array.new

    xabs = x_offset.abs
    yabs = y_offset.abs

    percent = rand
    first_half = percent
    second_half = 1 - percent

    xdir = x_offset > 0 ? 2 : 6
    ydir = y_offset > 0 ? 4 : 0

    if xabs < yabs
      temp_dist = (yabs * first_half).ceil
      moves << [ydir, temp_dist]
      moves << [xdir, xabs]
      temp_dist = (yabs * second_half).floor
      moves << [ydir, temp_dist]
    else
      temp_dist = (xabs * first_half).ceil
      moves << [xdir, temp_dist]
      moves << [ydir, yabs]
      temp_dist = (xabs * second_half).floor
      moves << [xdir, temp_dist]
    end

    @map[xpos][ypos] = 0;

    while moves.length > 0
      move = moves.pop
      while move[1] > 0
        xpos += directions(:eight)[move[0]][0]
        ypos += directions(:eight)[move[0]][1]
        @map[xpos][ypos] = 0
        move[1] = move[1] - 1
      end
    end
  end

  def create_corridors
    cw = @options[:cell_width]
    ch = @options[:cell_height]
    room, connection, other_room, wall, other_wall = nil

    (0..cw - 1).each do |i|
      (0..ch - 1).each do |j|
        room = @rooms[i][j]

        room[:connections].each do |connection|
          other_room = @rooms[connection[0]][connection[1]]

          if other_room[:cell_x] > room[:cell_x]
            wall = 2
            other_wall = 4
          elsif other_room[:cell_x] < room[:cell_x]
            wall = 4
            other_wall = 2
          elsif other_room[:cell_y] > room[:cell_y]
            wall = 3
            other_wall = 1
          elsif other_room[:cell_y] < room[:cell_y]
            wall = 1
            other_wall = 3
          end
          
          draw_corridor get_wall_position(room, wall), get_wall_position(other_room, other_wall)
        end
      end
    end
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
