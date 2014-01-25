require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'delve/event_queue'

class EventQueueTest < Minitest::Test

  def setup
    @queue = EventQueue.new
    @event = mock('object')
  end

  def test_initial_time_is_zero
    assert_equal 0, @queue.time
  end

  def test_raises_error_if_nil_event_is_added
    assert_raises RuntimeError do
      @queue.add nil, 10
    end
  end

  def test_raises_error_if_time_is_nil
    assert_raises RuntimeError do
      @queue.add @event, nil
    end
  end

  def test_get_returns_nil_if_no_events
    event = @queue.get

    assert_nil event
  end

  # fail if added event before current time?

end
