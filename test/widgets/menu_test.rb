require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/menu'

class MenuWidgetTest < Minitest::Test

  def setup
    @x = 5
    @y = 5
    @items = { 'n' => 'New Game', 'x' => 'Exit' }
    @menu = MenuWidget.new @x, @y, @items
  end

  # wrap over top
  # wrap over bottom
  # select by key not exist
  # select by key
  # rendering

  def test_initialising_without_x_position_raises_error
    assert_raises RuntimeError do
      MenuWidget.new nil, @y, @items
    end
  end

  def test_initialising_without_y_position_raises_error
    assert_raises RuntimeError do
      MenuWidget.new @x, nil, @items
    end
  end

  def test_initialising_without_items_raises_error
    assert_raises RuntimeError do
      MenuWidget.new @x, @y, nil
    end
  end

  def test_empty_items_fails
    assert_raises RuntimeError do
      MenuWidget.new @x, @y, Hash.new
    end
  end

  def test_render_fails_if_no_display_is_given
    assert_raises RuntimeError do
      @menu.draw nil
    end
  end

  def test_first_item_is_initially_selected
    assert_equal 'New Game', @menu.selected_item
  end

  def test_move_down_selects_second_item
    @menu.next
    assert_equal 'Exit', @menu.selected_item
  end

  def test_move_down_then_up_selects_first_item
    @menu.next
    @menu.previous
    assert_equal 'New Game', @menu.selected_item
  end

  def test_wrap_over_top
    @menu.previous
    assert_equal 'Exit', @menu.selected_item
  end

  def test_wrap_over_bottom
    @menu.next
    @menu.next
    assert_equal 'New Game', @menu.selected_item
  end

  def test_render
    display = mock('object')
    @menu.draw(display)
    assert false #complete this test
  end
end
