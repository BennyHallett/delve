require 'minitest'
require 'minitest/autorun'
require 'delve/game'

class GameTest < Minitest::Test

  def setup
    @display = mock('object')
    @input = mock('object')
    @screen_manager = mock('object')
    @game = Game.new @display, @screen_manager, @input
  end

  def test_fail_if_display_is_nil
    assert_raises RuntimeError do
      @game = Game.new nil, @screen_manager, @input
    end
  end

  def test_fail_if_screen_manager_is_nil
    assert_raises RuntimeError do
      @game = Game.new @display, nil, @input
    end
  end

  def test_fail_if_input_is_nil
    assert_raises RuntimeError do
      @game = Game.new @display, @screen_manager, nil
    end
  end

  def test_cannot_start_when_screen_manager_is_empty
    @screen_manager.expects(:empty?).returns(true)
    assert_raises RuntimeError do
      @game.start
    end
  end

  def test_start_game
    @screen_manager.expects(:empty?).returns(false)
    @screen_manager.expects(:render).with(@display)
    @screen_manager.expects(:update).with(@input).returns(true)
    @game.start
  end

end
