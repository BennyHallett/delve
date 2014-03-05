require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'delve/scheduler/simple_scheduler'

class SimpleSchedulerTest < Minitest::Test

  def setup
    @queue = mock('object')
    @scheduler = SimpleScheduler.new @queue
    @item = 'item'
  end

  def test_add
    @queue.expects(:add).with(@item, 0)
    @scheduler.add(@item, false)
  end

  def test_next_without_repeating
    @queue.expects(:get).returns(@item)
    assert_equal @item, @scheduler.next
  end

  def test_next_with_repeating
    @queue.expects(:get).twice.returns(@item)
    @queue.expects(:add).with(@item, 0)
    @scheduler.add(@item, true)
    @queue.expects(:add).with(@item, 0)
    @scheduler.next
    assert_equal @item, @scheduler.next
  end

end
