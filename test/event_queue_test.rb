require 'minitest'
require 'minitest/autorun'
require 'delve/event_queue'

class EventQueueTest < Minitest::Test

  def setup
    @queue = EventQueue.new
    @event = { :name => 'test-event' }
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

  def test_add_event_and_get_it_returns_same_event
    @queue.add @event, 1
    event = @queue.get
    
    assert_equal @event, event
  end

  def test_add_event_and_get_it_advances_time
    @queue.add @event, 10
    @queue.get

    assert_equal 10, @queue.time
  end

  def test_add_two_events_out_of_sequence_and_get_them
    first_event = { :place => 1 }
    second_event = { :place => 2 }
    @queue.add second_event, 10
    @queue.add first_event, 5

    first = @queue.get
    assert_equal 5, @queue.time

    second = @queue.get
    assert_equal 10, @queue.time    

    assert_equal first_event, first
    assert_equal second_event, second
  end

  def test_remove_event_that_doesnt_exist_returns_false
    result = @queue.remove({:event => 'fight'})
    assert_equal false, result
  end

  def test_remove_event_that_actually_exists
    @queue.add @event, 4
    result = @queue.remove @event

    assert result
  end

  def test_get_after_clear_returns_nil
    @queue.add @event, 5
    @queue.add @event, 8
    @queue.clear

    event = @queue.get
    
    assert_nil event
  end

end
