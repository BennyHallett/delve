require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/border'

class BorderWidgetTest < Minitest::Test

  def setup
    @x = 1
    @y = 1
    @width = 10
    @height = 4
    @border = BorderWidget.new @x, @y, @width, @height
  end

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      BorderWidget.new nil, @y, @width, @height
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      BorderWidget.new @x, nil, @width, @height
    end
  end

  def test_initialising_without_width_raises_error
    assert_raises RuntimeError do
      BorderWidget.new @x, @y, nil, @height
    end
  end

  def test_initalising_without_height_raises_error
    assert_raises RuntimeError do
      BorderWidget.new @x, @y, @width, nil
    end
  end

  def test_initalising_with_text_smaller_than_text_with_plus_four_fails
    assert_raises RuntimeError do
      BorderWidget.new @x, @y, 6, 2, 'Some long text'
    end
  end

  def test_render_fails_if_no_display_is_given
    assert_raises RuntimeError do
      @border.draw nil
    end
  end

  def test_initialize_with_colors
    BorderWidget.new @x, @y, @width, @height, nil, :red, :yellow
  end

  def test_render
    display = mock('onject')
    display.expects(:draw).times(24)
    @border.draw(display)
  end
end
