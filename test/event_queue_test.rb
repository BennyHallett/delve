require 'minitest'
require 'minitest/autorun'
require 'delve/event_queue'

class EventQueueTest < Minitest::Test

  def setup
    @queue = EventQueue.new
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
      @queue.add Hash.new, nil
    end
  end

  # fail if added event before current time

end
