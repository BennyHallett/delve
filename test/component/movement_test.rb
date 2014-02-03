require 'minitest'
require 'minitest/autorun'
require 'delve/component/movement'
require 'mocha/setup'

class MovementComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
  end

  # test init 4 way vs 8 way
  # test invalid movement style
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

end
