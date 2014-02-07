class Engine

  def initialize scheduler
    raise 'Cannot initialize engine when scheduler is nil' unless scheduler
    @scheduler = scheduler
  end

end
