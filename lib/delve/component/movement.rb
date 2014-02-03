class MovementComponent

  @@styles = [:fourway, :eightway]
  @@diagonal_error = 'Style is not sufficient to move diagonally'

  def initialize(parent, movement_style=:fourway)
    raise 'Cannot create movement component when parent is nil' unless parent
    @style = movement_style || :fourway
    raise 'Cannot create movement component with unknown style' unless @@styles.include?(@style)
  end

  def id
    :position
  end

  def style
    @style
  end

  def north_west
    raise @@diagonal_error unless diagonal_movement_is_valid
  end

  def north_east
    raise @@diagonal_error unless diagonal_movement_is_valid

  end

  def south_west
    raise @@diagonal_error unless diagonal_movement_is_valid

  end

  def south_east
    raise @@diagonal_error unless diagonal_movement_is_valid

  end

  private
  def diagonal_movement_is_valid
    @style == :eightway
  end

end
