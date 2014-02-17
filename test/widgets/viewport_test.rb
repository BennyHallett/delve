require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/viewport'

class ViewportWidgetTest < Minitest::Test

  def setup
    @x = 1
    @y = 1
    @width = 3
    @height = 3
    @world = mock('object')
    @display = mock('object')

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

  def test_draw_without_display_fails
    assert_raises RuntimeError do
      @viewport.draw nil
    end
  end

  def test_focus_at_5_5_renders_4_4_to_6_6
    @world.expects(:width).returns(20)
    @world.expects(:height).returns(100)
    expect_world 4, 4, 6, 6
    expect_draw 1, 1, 3, 3

    @viewport.focus 5, 5
    @viewport.draw @display
  end

  private
  def expect_world(sx, sy, ex, ey)
    (sx..ex).each do |x|
      (sy..ey).each do |y|
        @world.expects(:at).with(x, y).returns('.')
      end
    end
  end

  def expect_draw(sx, sy, ex, ey)
    (sx..ex).each do |x|
      (sy..ey).each do |y|
        @display.expects(:draw).with(x, y, '.')
      end
    end
  end

end
