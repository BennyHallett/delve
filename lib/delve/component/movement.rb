class MovementComponent

  @@styles = [:fourway, :eightway]
  @@diagonal_error = 'Style is not sufficient to move diagonally'

  def initialize(parent, movement_style=:fourway)
    raise 'Cannot create movement component when parent is nil' unless parent
    @parent = parent
    @style = movement_style || :fourway
    raise 'Cannot create movement component with unknown style' unless @@styles.include?(@style)
  end

  def id
    :movement
  end

  def style
    @style
  end

  def north_west
    raise @@diagonal_error unless diagonal_movement_is_valid
    move -1, -1
  end

  def north_east
    raise @@diagonal_error unless diagonal_movement_is_valid
    move 1, -1
  end

  def south_west
    raise @@diagonal_error unless diagonal_movement_is_valid
    move -1, 1
  end

  def south_east
    raise @@diagonal_error unless diagonal_movement_is_valid
    move 1, 1
  end

  def north
    move 0, -1
  end
  
  def east
    move 1, 0
  end
  
  def south
    move 0, 1
  end

  def west
    move -1, 0
  end

  private
  def diagonal_movement_is_valid
    @style == :eightway
  end

  def move(dx, dy)
    if @parent.has? :position
      pos = @parent.get :position

      if @parent.has? :collision
        col = @parent.get :collision

        if col.free?(pos.x + dx, pos.y + dy)
          pos.displace(dx, dy)
        end
      else
        pos.displace(dx, dy)
      end
    end
  end

end
