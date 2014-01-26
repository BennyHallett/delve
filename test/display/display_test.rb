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

  def test_partially_setting_options_keeps_changes_and_defults
    @display = Display.new(@renderer, { :height => 36, :width => 120 })
    opts = @display.options

    assert_equal 120, opts[:width]
    assert_equal 36, opts[:height]
    assert_equal :white, opts[:foreground]
    assert_equal :black, opts[:background]
  end

  def test_completely_define_options
    @display = Display.new(@renderer, { :height => 36, :width => 120, :background => :gray, :foreground => :yellow })
    opts = @display.options

    assert_equal 120, opts[:width]
    assert_equal 36, opts[:height]
    assert_equal :yellow, opts[:foreground]
    assert_equal :gray, opts[:background]
  end
 
  def test_not_initially_dirty_so_no_rendering_is_done
    @display.render
    # If it was dirty, then the renderer would be called, and the mock would report an error
  end

  def test_draw_with_no_colors_uses_default
    @display.draw 1, 1, '@'
    
    @renderer.expects(:render).with({ '1,1' => { :x => 1, :y => 1, :char => '@', :foreground => :white, :background => :black } })
    @display.render
  end
 
end
