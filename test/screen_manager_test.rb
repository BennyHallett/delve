require 'minitest'
require 'minitest/autorun'
require 'delve/screen_manager'

class ScreenManagerTest < Minitest::Test

  def setup
    @manager = ScreenManager.new
  end

  def test_empty_is_true_initially
    assert @manager.empty?
  end
end
