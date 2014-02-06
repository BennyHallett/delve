class Scheduler

  def initialize(event_queue)
    @queue = event_queue
    @current = nil
    @repeat = Array.new
  end

  def time
    @queue.time
  end

  def next
    @current = @queue.get
    @current
  end

  def remove(item)
    result = @queue.remove item

    index = @repeat.index item
    @events.delete_at index if index

    result
  end

  def clear
    @queue.clear
    @current = nil
    @repear = Array.new
  end

end
