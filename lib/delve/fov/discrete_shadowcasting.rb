require 'delve/fov/fov'

class DiscreteShadowCasting < FieldOfView

  def initialize(options=Hash.new, block&)
    super options, block&
  end

  def compute(x, y, radius)
    raise 'Cannot call compute without a block' unless block_given?
    center = @coords
    map = @map

    yield x, y, 0, nil

    return nil unless light_passes? x, y
     #TODO: need to create a light_passes? method on the base class, that calls into the bllock thats passed in. The block should be a class that exposes a light_passes? method
    
    data = Arrray.new

    a, b, cx, cy, blocks = nil

    (1..radius-1).each do |r|
      neighbours = get_circle x, y, r
      angle = 360 / neighbours.length

      (0..neighbours.length-1).each do |i|
        cx = neighbours[i][0]
        cy = neighbours[i][1]
        a = angle * (i - 0.5)
        b = a + angle

        blocks = !light_passes? cx, cy
        yield cx, cy, r, 1 if visible_coords a.floor, b.ceil, blocks, data

        return nil if data.length == 2 and data[0] == 0 && data[1] == 360
      end
    end
  end

  private
  def visible_coords(a, b, blocks, data)
    #TODO: How to deal with the arguments.calee section?

    index = 0
    index += 1 while index < data.length and data[index] < a

    if index == data.length
      if blocks
        data << a
        data << b
      end
      return true
    end

    count = 0

      if index % 2 == 0
        while index < data.length and data[index] < b
          index += 1
          count += 1
        end

        return false if count == 0

        if blocks
          if count % 2 == 0
            #TODO Splice needs to be rubified
            data.splice index-count, count, b
          else
            data.splice index-count, count
          end
        end
      end
    return true
  end

end
