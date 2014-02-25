require 'perlin_noise'
require 'delve/generator/map'

class Noise < Map

  @@grains = {
    :fine => 0.03,
    :coarse => 0.1
  }

  def initialize width, height, grain
    raise 'Cannot initialize noise generator when width is less than zero' if width < 0
    raise 'Cannot initialize noise generator when height is less than zero' if height < 0
    raise 'Cannot initialize noise generator when grain is not defined' unless grain
    raise 'Cannot initialize noise generator with unknown grain' unless @@grains.include?(grain)

    super width, height

    @grain = @@grains[grain]
    @inverse = 1/@grain
  end

  def generate
    noise = Perlin::Noise.new 2

    0.step((@width-1) * @grain, @grain) do |x|
      0.step((@height-1) * @grain, @grain).each do |y|
        yield(x*@inverse, y*@inverse, noise[x, y])
      end
    end
  end

end
