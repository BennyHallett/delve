require 'minitest'
require 'minitest/autorun'
require 'delve/entity'

class EntityTest < Minitest::Test

  def setup
    @entity = Entity.new
    @component = mock('object')
  end

  def test_has_component_returns_false_if_doesnt_exist
    assert !@entity.has?(:position)
  end

  def test_has_component_after_added
    @component.expects(:id).twice.returns(:position)
    @entity.add @component
    assert @entity.has?(:position)
  end

  def test_adding_same_component_more_than_once_fails
    @component.stubs(:id).returns(:position)
    @entity.add @component
    assert_raises RuntimeError do
      @entity.add @component
    end
  end

  def test_get_unknown_component_returns_nil
    assert_nil @entity.get :position
  end

  def test_get_component
    @component.stubs(:id).returns(:position)
    @entity.add @component
    assert_equal @component, @entity.get(:position)
  end

  def test_act
    @component.stubs(:id).returns(:actor)
    @component.expects(:act)
    @entity.add @component
    
    @entity.act
  end

end
