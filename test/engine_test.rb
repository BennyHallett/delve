require 'minitest'
require 'minitest/autorun'
require 'delve/engine'

class EngineTest < Minitest::Test

  def setup
  end

  def test_create_engine_without_scheduler_fails
    assert_raises RuntimeError do
      Engine.new nil
    end
  end

end
