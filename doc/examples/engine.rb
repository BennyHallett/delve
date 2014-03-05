require 'delve/engine'
require 'delve/scheduler/simple_scheduler'
require 'delve/event_queue'

class Actor

  def initialize(name)
    @name = name
  end

  def act
    puts "Actor #{@name} acting"
  end

end

queue = EventQueue.new
scheduler = SimpleScheduler.new(queue)
engine = Engine.new(scheduler)

a = Actor.new 'a'
b = Actor.new 'b'
c = Actor.new 'c'

scheduler.add(a, false)
scheduler.add(b, false)
scheduler.add(c, false)

engine.unlock
