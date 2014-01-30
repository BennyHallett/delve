class Noise

  def initialize width, height
    raise 'Cannot initialize noise generator when width is less than zero' if width < 0
    raise 'Cannot initialize noise generator when height is less than zero' if height < 0
  end

end
