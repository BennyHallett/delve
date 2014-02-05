require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/text'

class TextWidgetTest < Minitest::Test

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      TextWidget.new nil, 5, 'This is some text'
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      TextWidget.new 5, nil, 'This is some more text'
    end
  end

  def test_initialising_without_text_raises_error
    assert_raises RuntimeError do
      TextWidget.new 5, 5, nil
    end
  end

  def test_render_fails_if_no_display_is_given
    widget = TextWidget.new 2, 2, 'Text'
    assert_raises RuntimeError do
      widget.draw nil
    end
  end

  def test_render_centered_horizontally
    widget = TextWidget.new :center, 0, 'abc'
    display = mock('object')
    display.expects(:width).returns(10)
    display.expects(:draw).with(4, 0, 'a')
    display.expects(:draw).with(5, 0, 'b')
    display.expects(:draw).with(6, 0, 'c')
    widget.draw display
  end

  def test_render_centered_vertically
    widget = TextWidget.new 0, :center, 'abc'
    display = mock('object')
    display.expects(:height).returns(10)
    display.expects(:draw).with(0, 5, 'a')
    display.expects(:draw).with(1, 5, 'b')
    display.expects(:draw).with(2, 5, 'c')
    widget.draw display
  end

  def test_render
    display = mock('onject')
    widget = TextWidget.new 1, 1, 'Some text'
    display.expects(:draw).with(1, 1, 'S')
    display.expects(:draw).with(2, 1, 'o')
    display.expects(:draw).with(3, 1, 'm')
    display.expects(:draw).with(4, 1, 'e')
    display.expects(:draw).with(5, 1, ' ')
    display.expects(:draw).with(6, 1, 't')
    display.expects(:draw).with(7, 1, 'e')
    display.expects(:draw).with(8, 1, 'x')
    display.expects(:draw).with(9, 1, 't')
    widget.draw(display)
  end
end
