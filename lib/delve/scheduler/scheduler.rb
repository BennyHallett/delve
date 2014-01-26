class Scheduler

  def initialize(event_queue)
    @queue = event_queue
  end

  def time
    return @queue.time
  end

end
