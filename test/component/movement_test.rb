require 'minitest'
require 'minitest/autorun'
require 'delve/component/movement'
require 'mocha/setup'

class MovementComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
    @fourway = MovementComponent.new @parent
  end

  # test all diag movement on 4 way
  # test all movement styles

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

end
