require 'perlin_noise'

class Noise

  def initialize width, height
    raise 'Cannot initialize noise generator when width is less than zero' if width < 0
    raise 'Cannot initialize noise generator when height is less than zero' if height < 0

    @width = width
    @height = height
  end

  def generate
    noise = Perlin::Noise.new 2

    (0..@width-1).each do |x|
      (0..@height-1).each do |y|
        yield(x, y, noise[x, y])
      end
    end
  end

end
