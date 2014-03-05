require 'delve/scheduler/scheduler'

class SimpleScheduler < Scheduler

  def initialize(event_queue)
    super event_queue
  end

  def add(item, repeat)
    @queue.add item, 0
    super item, repeat
  end

  def next
    if @current and !@repeat.index(@current).nil?
      @queue.add(@current, 0)
    end
    super
  end

end
