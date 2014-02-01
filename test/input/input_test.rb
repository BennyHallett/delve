require 'minitest'
require 'minitest/autorun'
require 'delve/input/input'
require 'mocha/setup'

class InputTests < MiniTest::Test

  def setup
    @handler = mock('object')
    @input = Input.new @handler
  end

  def test_error_raised_if_handler_is_nil
    Input.new @handler
  end

  def test_wait_for_input_defers_to_handler
    @handler.expects(:wait_for_input)
    @input.wait_for_input
  end
end
