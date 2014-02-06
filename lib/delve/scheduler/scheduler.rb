class Scheduler

  def initialize(event_queue)
    @queue = event_queue
    @current = nil
  end

  def time
    @queue.time
  end

  def next
    @current = @queue.get
    @current
  end

end
