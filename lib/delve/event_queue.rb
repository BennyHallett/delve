class EventQueue
  def initialize
    @time = 0
  end

  def time
    @time
  end

  def add(event, time)
    raise 'Unable to add a nil event' unless event
    raise 'Unable to schedule event with no time' unless time
  end
end
