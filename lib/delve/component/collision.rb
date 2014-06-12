class CollisionComponent
  def initialize(parent, detector)
    raise 'Cannot create collision component when parent is nil' unless parent
    raise 'Cannot create collision component when detector is nil' unless detector

    @parent = parent
    @detector = detector
  end

  def id
    :collision
  end

  def free?(x, y)
    @detector.free?(x, y)
  end
end
