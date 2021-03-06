require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/multi_line'

class MultiLineWidgetTest < Minitest::Test

  def setup
    @x = 4
    @y = 5
    @lines = [ 'This is some text', 'With a new line' ]
    @length = @lines[0].length + @lines[1].length
    @widget = MultiLineWidget.new @x, @y, @lines
    @display = mock('object')
  end

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      MultiLineWidget.new nil, @y, @lines
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      MultiLineWidget.new @x, nil, @lines
    end
  end

  def test_initialising_without_text_raises_error
    assert_raises RuntimeError do
      MultiLineWidget.new @x, @y, nil
    end
  end

  def test_render_fails_if_no_display_is_given
    assert_raises RuntimeError do
      @widget.draw nil
    end
  end

  def test_center_horizontally_on_odd_width_screen
    @widget = MultiLineWidget.new :center, @y, ['a']
    @display.expects(:width).returns(11)
    @display.expects(:draw).with(6, @y, 'a')
    @widget.draw @display
  end

  def test_center_horizontally_on_even_width_screen
    @widget = MultiLineWidget.new :center, @y, ['a']
    @display.expects(:width).returns(10)
    @display.expects(:draw).with(5, @y, 'a')
    @widget.draw @display
  end

  def test_center_vertically_on_odd_width_screen
    @widget = MultiLineWidget.new @x, :center, ['a']
    @display.expects(:height).returns(11)
    @display.expects(:draw).with(@x, 6, 'a')
    @widget.draw @display
  end

  def test_center_vertically_on_even_width_screen
    @widget = MultiLineWidget.new @x, :center, ['a']
    @display.expects(:height).returns(10)
    @display.expects(:draw).with(@x, 5, 'a')
    @widget.draw @display
  end


  def test_render
    @display.expects(:draw).times(@length)
    @widget.draw @display
  end
end
