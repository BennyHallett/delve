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

    @viewport = ViewportWidget.new @x, @y, @width, @height, @world
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

  def test_focus_west_of_0_fails
    assert_raises RuntimeError do
      @viewport.focus -1, 5
    end
  end

  def test_focus_north_of_0_fails
    assert_raises RuntimeError do
      @viewport.focus 4, -1
    end
  end

  def test_focus_east_of_width_fails
    @world.expects(:width).returns(10)
    assert_raises RuntimeError do
      @viewport.focus 10, 1
    end
  end

  def test_focus_south_off_height_fails
    @world.stubs(:width).returns(18)
    @world.expects(:height).returns(9)
    assert_raises RuntimeError do
      @viewport.focus 1, 9
    end
  end

end
