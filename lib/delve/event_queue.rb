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
    
    @events << { :event => event, :time => time }
  end

  def get
    return nil unless @events.length > 0
    
    @time += @events.first[:time]
    @events.first[:event]
  end
end
