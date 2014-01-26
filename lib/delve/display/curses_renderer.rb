require 'curses'

class CursesRenderer

  def init
    Curses.init_screen
  end

  def exit
    Curses.close_screen
  end

end
