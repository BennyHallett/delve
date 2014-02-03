require 'minitest'
require 'minitest/autorun'
require 'delve/component/position'
require 'mocha/setup'

class PositionComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
    @pos = PositionComponent.new @parent
  end

  def test_initialize_component_with_nil_parent_fails
    assert_raises RuntimeError do
      PositionComponent.new nil
    end
  end

  def test_initial_position_is_zero_zero
    assert_equal 0, @pos.x
    assert_equal 0, @pos.y
  end

  def test_id_is_position
    assert_equal :position, @pos.id
  end

  def test_set_position
    @pos.set 4, 6
    
    assert_equal 4, @pos.x
    assert_equal 6, @pos.y
  end

  def test_displace_position
    @pos.set 4, 6
    @pos.displace -1, 1

    assert_equal 3, @pos.x
    assert_equal 7, @pos.y
  end

end
