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

end
