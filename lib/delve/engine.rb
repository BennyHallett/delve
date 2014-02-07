class Engine

  def initialize scheduler
    raise 'Cannot initialize engine when scheduler is nil' unless scheduler
    @scheduler = scheduler
    @lock = 1
  end

  def locked?
    @lock > 0
  end

  def lock
    @lock += 1
  end

  def unlock
    @lock -= 1

    while !locked? do
      actor = @scheduler.next
      if !actor
        lock
        break
      end
      actor.act
    end
  end

end
