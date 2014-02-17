require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/viewport'

class ViewportWidgetTest < Minitest::Test

  def setup
    @x = 1
    @y = 0
    @width = 11
    @height = 7
    @world = mock('object')
  end

  def test_initialize_without_x_fails
    assert_raises RuntimeError do
      ViewportWidget.new nil, @y, @width, @height, @world
    end
  end

  def test_initialize_without_y_fails
    assert_raises RuntimeError do
      ViewportWidget.new @x, nil, @width, @height, @world
    end
  end

  def test_initialize_without_width_fails
    assert_raises RuntimeError do
      ViewportWidget.new @x, @y, nil, @height, @world
    end
  end

  def test_initialize_without_height_fails
    assert_raises RuntimeError do
      ViewportWidget.new @x, @y, @width, nil, @world
    end
  end

  def test_initialize_without_world_fails
    assert_raises RuntimeError do
      ViewportWidget.new @x, @y, @width, @height, nil
    end
  end

end
