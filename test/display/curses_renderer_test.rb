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
    Curses.expects(:init_screen)
    Curses.expects(:nl)
    Curses.expects(:noecho)
    Curses.expects(:clear)
    @renderer.expects(:draw).with(2, 2, '@', :white, :black)
    @renderer.init
    @renderer.render({ '1,1' => {:x => 2, :y => 2, :char => '@', :foreground => :white, :background => :black} })
    @renderer.exit
  end

  def test_wait_for_input
    Curses.expects(:getch)
    @renderer.wait_for_input
  end

end
