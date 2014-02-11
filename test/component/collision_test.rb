require 'minitest'
require 'minitest/autorun'
require 'delve/component/collision'
require 'mocha/setup'

class CollisionComponentTest < Minitest::Test

  def setup
    @parent = mock('object')
    @detector = mock('object')
    @collision = CollisionComponent.new @parent, @detector
  end

  def test_initialize_component_with_nil_parent_fails
    assert_raises RuntimeError do
      CollisionComponent.new nil, @detector
    end
  end

  def test_initialize_component_with_nil_world_fails
    assert_raises RuntimeError do
      CollisionComponent.new @parent, nil
    end
  end

  def test_id
    assert_equal :collision, @collision.id
  end

  def test_free_returns_true_if_world_tile_is_free
    @detector.expects(:free).with(1, 2).returns(true)
    assert @collision.free(1, 2)
  end

  def test_free_returns_false_if_world_tile_is_not_free
    @detector.expects(:free).with(2, 1).returns(false)
    assert !@collision.free(2, 1)
  end
end
