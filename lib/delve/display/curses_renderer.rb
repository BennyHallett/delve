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

  def render(data)
    Curses.clear
    data.keys.each do |key|
      draw_data = data[key]
      draw(draw_data[:x], draw_data[:y], draw_data[:char], draw_data[:foreground], draw_data[:background])
    end   
    Curses.refresh
  end

  def draw(x, y, char, fg, bg)
    Curses.setpos(x, y)
    Curses.addstr(char)
  end

  def wait_for_input
    Curses.getch
  end

end
