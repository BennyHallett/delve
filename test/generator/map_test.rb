require 'minitest'
require 'minitest/autorun'
require 'delve/generator/map'

class MapTest < Minitest::Test

  def test_initialize_map
    @map = Map.new 10, 15
    assert_equal 10, @map.width
    assert_equal 15, @map.height
  end

  def assert_initialize_map_with_defaults
    @map = Map.new
    assert_equal 80, @map.width
    assert_equal 24, @map.height
  end

  def test_fill_map_with_ones
    @map = Map.new 10, 10
    result = @map.fill 1
    tester = mock('object')
    tester.expects(:go).with(1).times(100)
    result.each do |y|
      y.each do |val|
        tester.go(val)
      end
    end
  end

end
