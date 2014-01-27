require 'curses'

class CursesRenderer

  def init
    Curses.init_screen
    Curses.start_color
    Curses.nl
    Curses.noecho
    Curses.init_pair(Curses::COLOR_WHITE, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
  end

  def exit
    Curses.close_screen
  end

  def draw(x, y, char, fg, bg)
    Curses.clear
    Curses.setpos(x, y)
    Curses.attron(Curses.color_pair(Curses::COLOR_WHITE)) do
      Curses.addstr(char)
    end
  end

  def render
    Curses.refresh
  end

end
