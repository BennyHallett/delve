require 'minitest'
require 'minitest/autorun'
require 'delve/screen_manager'

class ScreenManagerTest < Minitest::Test

  def setup
    @manager = ScreenManager.new
    @screen = mock('object')
  end

  def test_empty_is_true_initially
    assert @manager.empty?
  end

  def test_push_first_screen
    @manager.push_screen @screen
    assert !@manager.empty?
  end

  def test_push_pop_first_screen
    @manager.push_screen @screen
    @manager.pop_screen
    assert @manager.empty?
  end

  def test_send_events_to_top_screen
    @screen.expects(:handle_key)
    first_screen = mock('object')
    first_screen.expects(:handle_key).never

    @manager.push_screen first_screen
    @manager.push_screen @screen
    @manager.handle_key 'a'
  end
end
