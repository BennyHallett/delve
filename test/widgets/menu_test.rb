require 'minitest'
require 'minitest/autorun'
require 'delve/widgets/menu'

class MenuWidgetTest < Minitest::Test

  def setup
    @x = 5
    @y = 5
    @items = { 'n' => 'New Game', 'x' => 'Exit' }
    @menu = MenuWidget.new @x, @y, @items
    @display = mock('object')
  end

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

  def test_false_returned_if_selecting_item_that_doesnt_exist
    assert !@menu.select('p')
    assert_equal 'New Game', @menu.selected_item
  end

  def test_selecting_by_key
    assert @menu.select('x')
    assert_equal 'Exit', @menu.selected_item
  end

  def test_render
    @display.expects(:draw).times(12)
    @menu.draw(@display)
  end

  def test_center_horizontally
    @menu = MenuWidget.new :center, @y, {'a' => 'a'}
    @display.expects(:width).returns(11)
    @display.expects(:draw).with(6, @y, 'a', :red, :white)
    @menu.draw @display
  end

  def test_center_vertically
    @menu = MenuWidget.new @x, :center, {'a' => 'a'}
    @display.expects(:height).returns(11)
    @display.expects(:draw).with(@x, 6, 'a', :red, :white)
    @menu.draw @display
  end

  def test_set_colors
    MenuWidget.new @x, @y, @items, :red, :black, :green
  end
end
