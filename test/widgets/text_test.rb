require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/text'

class TextWidgetTest < Minitest::Test

  def setup
  end

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
end
