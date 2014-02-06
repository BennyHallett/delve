require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'delve/scheduler/scheduler'

class SchedulerTest < Minitest::Test

  def setup
    @queue = mock('object')
    @scheduler = Scheduler.new @queue
    @item = 'item'
  end

  def test_get_time_from_event_queue
    @queue.expects(:time).returns(10)
    time = @scheduler.time
    assert_equal 10, time
  end

  def test_get_next
    @queue.expects(:get).returns(@item)
    assert_equal @item, @scheduler.next
  end

  def test_remove_unknown_item_from_queue_returns_false
    @queue.expects(:remove).with(@item).returns(false)
    assert !@scheduler.remove(@item)
  end

  def test_remove_known_item_from_queue_returns_true
    @queue.expects(:remove).with(@item).returns(true)
    assert @scheduler.remove(@item)
  end

  def test_clear_clears_queue
    @queue.expects(:clear)
    @scheduler.clear
  end

  ## Not sure how exactly how to test this method

  def test_add_non_repeating_item
    @scheduler.add(@item)
  end

  def test_add_repeating_item
    @scheduler.add(@item, true)
  end

end
