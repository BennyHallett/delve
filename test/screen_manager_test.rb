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
end
