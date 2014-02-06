require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'delve/scheduler/scheduler'

class SchedulerTest < Minitest::Test

  def setup
    @queue = mock('object')
    @scheduler = Scheduler.new @queue
  end

  def test_get_time_from_event_queue
    @queue.expects(:time).returns(10)
    time = @scheduler.time
    assert_equal 10, time
  end

  def test_get_next
    expected_result = 'Expected Result'
    @queue.expects(:get).returns(expected_result)
    assert_equal expected_result, @scheduler.next
  end

  def test_remove_unknown_item_from_queue_returns_false
    event = 'event'
    @queue.expects(:remove).with(event).returns(false)
    assert !@scheduler.remove(event)
  end

  def test_remove_known_item_from_queue_returns_true
    event = 'event'
    @queue.expects(:remove).with(event).returns(true)
    assert @scheduler.remove(event)
  end

end
