require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'curses'
require 'delve/input/curses_input'

class CursesInputTests < Minitest::Test

  def setup
    @input = CursesInput.new
  end

  def test_wait_for_input
    Curses.expects(:getch)
    @input.wait_for_input
  end

  def test_wait_for_non_character_input
    Curses.expects(:getch).returns(263)
    key = @input.wait_for_input
    assert_equal :backspace, key
  end

end
