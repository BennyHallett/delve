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

end
