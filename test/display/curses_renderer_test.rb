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
    Curses.expects(:nl)
    Curses.expects(:noecho)
    @renderer.init
  end

  def test_exit_calls_curses_close
    Curses.expects(:close_screen)
    @renderer.exit
  end

  def test_draw
    Curses.expects(:setpos)
    Curses.expects(:attron)
    Curses.expects(:addstr)
    Curses.expects(:init_screen)
    Curses.expects(:nl)
    Curses.expects(:noecho)
    @renderer.init
    @renderer.draw 2, 2, '@', :white, :black
    @renderer.exit
  end

  def test_render
    Curses.expects(:refresh)
    Curses.expects(:setpos)
    Curses.expects(:attron)
    Curses.expects(:addstr)
    Curses.expects(:init_screen)
    Curses.expects(:nl)
    Curses.expects(:noecho)
    @renderer.init
    @renderer.draw 2, 2, '@', :white, :black
    @renderer.render
    @renderer.exit
  end

end
