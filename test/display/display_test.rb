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

  def test_create_display_with_no_options_sets_defaults
    opts = @display.options

    assert_equal 80, opts[:width]
    assert_equal 24, opts[:height]
    assert_equal :white, opts[:foreground]
    assert_equal :black, opts[:background]
  end

end
