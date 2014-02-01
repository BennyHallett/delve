require 'curses'

class CursesRenderer

  def init
    Curses.init_screen
    Curses.start_color
    Curses.nl
    Curses.noecho
    Curses.curs_set 0
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
    # Seem to need to flip x and y
    Curses.setpos(y, x)
    Curses.addstr(char)
  end
end
