require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/progress'
require 'mocha/setup'

class ProgressWidgetTest < Minitest::Test

  def setup
    @x = 1
    @y = 1
    @width = 5
    @current = 12
    @max = 12
    @bg = :white
    @fg = :red
    @widget = ProgressWidget.new @x, @y, @width, @current, @max, @fg, @bg
    @display = mock('object')
  end

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new nil, @y, @width, @current, @max, @fg, @bg
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, nil, @width, @current, @max, @fg, @bg
    end
  end

  def test_initialising_without_width_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, @y, nil, @current, @max, @fg, @bg
    end
  end

  def test_initialising_without_fg_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, @y, @width, @current, @max, nil, @bg
    end
  end

  def test_initialising_without_bg_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, @y, @width, @current, @max, @fg, nil
    end
  end

  def test_initialising_without_current_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, @y, @width, nil, @max, @fg, @bg
    end
  end

  def test_initialising_without_max_raises_error
    assert_raises RuntimeError do
      ProgressWidget.new @x, @y, @width, @current, nil, @fg, @bg
    end
  end

  def test_render_fails_if_no_display_is_given
    assert_raises RuntimeError do
      @widget.draw nil
    end
  end

  def test_render_full
    @display.expects(:draw).with(1, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(2, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(3, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(4, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(5, 1, ' ', @fg, @fg)
    @widget.draw(@display)
  end

  def test_partially_full
    @widget.current = 6
    @display.expects(:draw).with(1, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(2, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(3, 1, ' ', @fg, @fg)
    @display.expects(:draw).with(4, 1, ' ', @bg, @bg)
    @display.expects(:draw).with(5, 1, ' ', @bg, @bg)
    @widget.draw(@display)
  end

  def test_set_current_value
    @widget.current = 2
    assert_equal 2, @widget.current
  end

  def test_set_max_value
    @widget.max = 100
    assert_equal 100, @widget.max
  end
end
