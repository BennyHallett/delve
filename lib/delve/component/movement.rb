class MovementComponent
  def initialize(parent, movement_style=:fourway)
    raise 'Cannot create movement component when parent is nil' unless parent
    @style = movement_style || :fourway
  end

  def id
    :position
  end

  def style
    @style
  end
end
