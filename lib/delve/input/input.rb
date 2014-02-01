class Input

  def initialize(handler)
    raise 'Cannot initialize display with no renderer' unless handler
    @handler = handler
  end

  def wait_for_input
    @handler.wait_for_input
  end

end
