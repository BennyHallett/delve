require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/key_value'

class KeyValueWidgetTest < Minitest::Test

  def setup
    @x = 1
    @y = 1
    @label = 'Name'
    @value = 'Hero'
    @widget = KeyValueWidget.new @x, @y, @label, @value
    @display = mock('object')
  end

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      KeyValueWidget.new nil, @y, @label, @value
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      KeyValueWidget.new @x, nil, @label, @value
    end
  end

  def test_initialising_without_label_raises_error
    assert_raises RuntimeError do
      KeyValueWidget.new @x, @y, nil, @value
    end
  end

  def test_initialising_without_value_raises_error
    assert_raises RuntimeError do
      KeyValueWidget.new @x, @y, @label, nil
    end
  end

  def test_render_fails_if_no_display_is_given
    assert_raises RuntimeError do
      @widget.draw nil
    end
  end

  def test_get_value
    assert_equal @value, @widget.value
  end

  def test_set_value
    @widget.value = 'Nameless'
    assert_equal 'Nameless', @widget.value
  end

  def test_render
    @display.expects(:draw).with(1, 1, 'N')
    @display.expects(:draw).with(2, 1, 'a')
    @display.expects(:draw).with(3, 1, 'm')
    @display.expects(:draw).with(4, 1, 'e')
    @display.expects(:draw).with(5, 1, ':')
    @display.expects(:draw).with(6, 1, ' ')
    @display.expects(:draw).with(7, 1, 'H')
    @display.expects(:draw).with(8, 1, 'e')
    @display.expects(:draw).with(9, 1, 'r')
    @display.expects(:draw).with(10, 1, 'o')
    @widget.draw(@display)
  end
end
