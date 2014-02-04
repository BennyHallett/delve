require 'minitest'
require 'minitest/autorun'
require 'delve/component/movement'
require 'mocha/setup'

class MovementComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
    @position = mock('object')
    @fourway = MovementComponent.new @parent
    @eightway = MovementComponent.new @parent, :eightway
  end

  # test all movement styles

  def test_id_is_movement
    assert_equal :movement, @fourway.id
  end

  def test_initialize_component_with_nil_parent_fails
    assert_raises RuntimeError do
      MovementComponent.new nil, :fourway
    end
  end

  def test_initialize_component_with_nil_movement_style_defaults_to_fourway
    move = MovementComponent.new @parent, nil
    assert_equal :fourway, move.style
  end

  def test_initialize_with_eight_way_movement
    move = MovementComponent.new @parent, :eightway
    assert_equal :eightway, move.style
  end

  def test_initialize_with_invalid_movement_style
    assert_raises RuntimeError do
      MovementComponent.new @parent, :unknown
    end
  end

  def test_moving_north_west_in_fourway_fails
    assert_raises RuntimeError do
      @fourway.north_west
    end
  end

  def test_moving_north_east_in_fourway_fails
    assert_raises RuntimeError do
      @fourway.north_east
    end
  end

  def test_moving_south_west_in_fourway_fails
    assert_raises RuntimeError do
      @fourway.south_west
    end
  end

  def test_moving_south_east_in_fourway_fails
    assert_raises RuntimeError do
      @fourway.south_east
    end
  end

  def test_move_north
    set_movement_expectations 0, -1
    @eightway.north
  end

  def test_move_north_east
    set_movement_expectations 1, -1
    @eightway.north_east
  end

  def test_move_east
    set_movement_expectations 1, 0
    @eightway.east
  end

  def test_move_south_east
    set_movement_expectations 1, 1
    @eightway.south_east
  end

  def test_move_south
    set_movement_expectations 0, 1
    @eightway.south
  end

  def test_move_south_west
    set_movement_expectations -1, 1
    @eightway.south_west
  end

  def test_move_west
    set_movement_expectations -1, 0
    @eightway.west
  end

  def test_move_north_west
    set_movement_expectations -1, -1
    @eightway.north_west
  end

  private
  def set_movement_expectations(dx, dy)
    @parent.expects(:has?).with(:position).returns(true)
    @parent.expects(:get).with(:position).returns(@position)
    @position.expects(:displace).with(dx, dy)
  end

end
