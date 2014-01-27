require 'curses'

class CursesRenderer

  def init
    Curses.init_screen
    Curses.start_color
    Curses.nl
    Curses.noecho
  end

  def exit
    Curses.close_screen
  end

  def draw(x, y, char, fg, bg)
    Curses.setpos(x, y)
    Curses.addstr(char)
  end

  def render
    Curses.refresh
  end

end
