require 'minitest'
require 'minitest/autorun'
require 'delve/game'

class GameTest < Minitest::Test

  def setup
    @display = mock('object')
    @screen_manager = mock('object')
    @game = Game.new @display, @screen_manager
  end

  def test_fail_if_display_is_nil
    assert_raises RuntimeError do
      @game = Game.new nil, @screen_manager
    end
  end

  def test_fail_if_screen_manager_is_nil
    assert_raises RuntimeError do
      @game = Game.new @display, nil
    end
  end

  def test_cannot_start_when_screen_manager_is_empty
    @screen_manager.expects(:empty?).returns(true)
    assert_raises RuntimeError do
      @game.start
    end
  end

end
