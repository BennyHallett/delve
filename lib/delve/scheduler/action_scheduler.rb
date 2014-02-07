require 'delve/scheduler/scheduler'

class ActionScheduler < Scheduler

  @@default_duration = 1

  def initialize(event_queue)
    @duration = @@default_duration
    super event_queue
  end

  def clear
    super
  end

  def remove(item)
    @duration = @@default_duration if item == @current
    super item
  end

  def add(item, repeat, time=@@default_duration)
    @queue.add item, time
    super item, repeat
  end

  def set_duration(time)
      @duration = time if @current
  end

  def next
    if @current and !@repeat.index(@current).nil?
      @queue.add(@current, @duration || @@default_duration)
      @duration = @@default_duration
    end
    super
  end

end
