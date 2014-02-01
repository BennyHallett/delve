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

end
