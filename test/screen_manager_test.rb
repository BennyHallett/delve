require 'minitest'
require 'minitest/autorun'
require 'delve/screen_manager'

class ScreenManagerTest < Minitest::Test

  def setup
    @manager = ScreenManager.new
    @screen = mock('object')
    @display = mock('object')
  end

  def test_empty_is_true_initially
    assert @manager.empty?
  end

  def test_push_first_screen
    @manager.push_screen @screen
    assert !@manager.empty?
  end

  def test_push_pop_first_screen
    @manager.push_screen @screen
    @manager.pop_screen
    assert @manager.empty?
  end

  def test_send_events_to_top_screen
    @screen.expects(:update)
    first_screen = mock('object')
    first_screen.expects(:update).never

    @manager.push_screen first_screen
    @manager.push_screen @screen
    @manager.update
  end

  def test_send_events_with_no_screen_should_fail
    assert_raises RuntimeError do
      @manager.update
    end
  end

  def test_cannot_render_with_no_screen
    assert_raises RuntimeError do
      @manager.render @display
    end
  end

  def test_error_raised_when_display_is_nil
      @manager.push_screen @screen
    assert_raises RuntimeError do
      @manager.render nil
    end
  end

  def test_top_screen_is_rendered
    @screen.expects(:render).with(@display)
    @screen.expects(:partial?).returns(false)
    first_screen = mock('object')
    first_screen.expects(:render).never

    @manager.push_screen first_screen
    @manager.push_screen @screen
    @manager.render @display
  end

  def test_partial_screen_rendering
    @screen.expects(:render).with(@display)
    @screen.expects(:partial?).returns(true)
    first_screen = mock('object')
    first_screen.expects(:render).never
    first_screen.expects(:partial?).never
    second_screen = mock('object')
    second_screen.expects(:render).with(@display)
    second_screen.expects(:partial?).returns(false)

    @manager.push_screen first_screen
    @manager.push_screen second_screen
    @manager.push_screen @screen
    @manager.render @display
  end
end
