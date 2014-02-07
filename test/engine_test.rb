require 'minitest'
require 'minitest/autorun'
require 'delve/engine'

class EngineTest < Minitest::Test

  def setup
    @scheduler = mock('object')
    @actor = mock('object')
    @engine = Engine.new @scheduler
  end

  def test_create_engine_without_scheduler_fails
    assert_raises RuntimeError do
      Engine.new nil
    end
  end

  def test_engine_initially_locked
    assert @engine.locked?
  end

  def test_unlock_with_no_actors_calls_scheduler_then_relocks
    @scheduler.expects(:next).returns(nil)
    @engine.unlock
    assert @engine.locked?
  end

  def test_scheduled_actor_acts_when_unlocked
    @scheduler.expects(:next).twice.returns(@actor).returns(nil)
    @actor.expects(:act)
    @engine.unlock
    assert @engine.locked?
  end

end
