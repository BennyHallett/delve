class PositionComponent
  def initialize(parent)
    raise 'Cannot create position comonent when parent is nil' unless parent

    @x = 0
    @y = 0
  end

  def id
    :position
  end

  def x
    @x
  end

  def y
    @y
  end

  def set(x, y)
    @x = x
    @y = y
  end

  def displace(dx, dy)
    @x += dx
    @y += dy
  end
end
