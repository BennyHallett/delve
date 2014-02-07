require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'delve/scheduler/action_scheduler'

class ActionSchedulerTest < Minitest::Test

  def setup
    @queue = mock('object')
    @scheduler = ActionScheduler.new @queue
    @item = 'item'
    @time = 10
  end

  def test_clear_calls_subclass_clear
    @queue.expects(:clear)
    @scheduler.clear
  end

  def test_remove_with_unknown_item
    @queue.expects(:remove).with(@item).returns(false)
    assert !@scheduler.remove(@item)
  end

  def test_remove_with_known_item
    @queue.expects(:remove).with(@item).returns(true)
    assert @scheduler.remove(@item)
  end

  def test_add_with_default_time
    @queue.expects(:add).with(@item, 1)
    @scheduler.add(@item, true)
  end

  def test_add_without_default_time
    @queue.expects(:add).with(@item, @time)
    @scheduler.add(@item, false, @time)
  end

  def test_next_without_repeating
    @queue.expects(:get).returns(@item)
    assert_equal @item, @scheduler.next
  end

  def test_next_with_repeating
    @queue.expects(:get).twice.returns(@item)
    @queue.expects(:add).with(@item, 1)
    @scheduler.add(@item, true)
    @queue.expects(:add).with(@item, 1)
    @scheduler.next
    assert_equal @item, @scheduler.next
  end

end
