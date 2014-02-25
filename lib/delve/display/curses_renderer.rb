require 'curses'

class CursesRenderer

  @@colors = {
    :black      => Curses::COLOR_BLACK,
    :red        => Curses::COLOR_RED,
    :blue       => Curses::COLOR_BLUE,
    :white      => Curses::COLOR_WHITE,
    :cyan       => Curses::COLOR_CYAN,
    :green      => Curses::COLOR_GREEN,
    :magenta    => Curses::COLOR_MAGENTA,
    :yellow     => Curses::COLOR_YELLOW
  }

  def init
    Curses.init_screen
    Curses.start_color
    Curses.nl
    Curses.noecho
    Curses.curs_set 0
    @pairs = Array.new
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
    pair = "#{fg.to_s},#{bg.to_s}"
    if !@pairs.include? pair
      @pairs.push pair
      Curses.init_pair(@pairs.index(pair)+1, @@colors[fg], @@colors[bg])
    end
    # Seem to need to flip x and y
    index = @pairs.index(pair)+1
    Curses.setpos(y, x)
    Curses.attron(Curses.color_pair(index)) do
      begin
        Curses.addstr(char)
      rescue TypeError => e
        raise 'The char was ' + char.to_s
      end
    end
  end

  def width
    Curses.cols
  end

  def height
    Curses.lines
  end
end
