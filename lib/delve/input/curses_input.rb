require 'curses'

class CursesInput

  def wait_for_input
    Curses.getch
  end

end
