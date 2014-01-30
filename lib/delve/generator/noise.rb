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

    0.step((@width-1) * 0.1, 0.1) do |x|
      0.step((@height-1) * 0.1, 0.1).each do |y|
        yield(x*10, y*10, noise[x, y])
      end
    end
  end

end
