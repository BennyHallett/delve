class EventQueue
  def initialize
    @time = 0
    @events = Array.new
  end

  def time
    @time
  end

  def add(event, time)
    raise 'Unable to add a nil event' unless event
    raise 'Unable to schedule event with no time' unless time
    
    i = @events.length
    (0..@events.length - 1).each do |e|
      if @events[e][:time] > time
        i = e
        break
      end
    end

    @events.insert(i, { :event => event, :time => time })
  end

  def get
    return nil unless @events.length > 0
    
    e = @events.shift

    if e[:time] > 0
      @time += e[:time]
      @events.each { |x| x[:time] -= e[:time] }
    end
    e[:event]
  end
end
