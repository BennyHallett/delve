require 'minitest'
require 'minitest/autorun'
require 'delve/entity'

class EntityTest < Minitest::Test

  # Test adding same component multiple times fails

  def setup
    @entity = Entity.new
    @component = mock('object')
  end

  def test_has_component_returns_false_if_doesnt_exist
    assert !@entity.has?(:position)
  end

  def test_has_component_after_added
    @component.expects(:id).returns(:position)
    @entity.add_component @component
    assert @entity.has?(:position)
  end

end
