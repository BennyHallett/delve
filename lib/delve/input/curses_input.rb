require 'curses'

class CursesInput

  @@keys = {
    263 => :backspace,
    330 => :delete,
    258 => :down_arrow,
    360 => :end,
    343 => :enter,
    262 => :home,
    331 => :insert,
    260 => :left_arrow,
    338 => :page_down,
    339 => :page_up,
    261 => :right_arrrow,
    259 => :up_arrow
  }

  def wait_for_input
    value = Curses.getch
    if @@keys.include? value
      value = @@keys[value]
    end
    value
  end

end
