require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'curses'
require 'delve/display/curses_renderer'

class CursesRendererTests < Minitest::Test

  def setup
    @renderer = CursesRenderer.new
  end

  def test_init_calls_curses_init
    Curses.expects(:init_screen)
    @renderer.init
  end

end
