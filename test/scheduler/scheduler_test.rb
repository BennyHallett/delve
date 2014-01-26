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

  

end
