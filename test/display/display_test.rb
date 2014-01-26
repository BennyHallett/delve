require 'minitest'
require 'minitest/autorun'
require 'delve/display/display'
require 'mocha/setup'

class DisplayTests < MiniTest::Test

  def setup
    @renderer = mock('object')
    @display = Display.new @renderer
  end

  def test_create_display_with_no_renderer_raises_error
    assert_raises RuntimeError do
      @display = Display.new nil
    end
  end

end
