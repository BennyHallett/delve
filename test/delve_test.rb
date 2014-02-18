require 'minitest'
require 'minitest/autorun'
require 'delve'
require 'fileutils'

class DelveTest < Minitest::Test

  def setup
    @base_path = '/home/me'
    @name = 'crawler'
    @full_path = "#{@base_path}/#{@name}"
    @delve = Delve.new @name
  end

  def test_initialize_without_name_fails
    assert_raises RuntimeError do
      Delve.new nil
    end
  end

  def test_set_unknown_renderer_fails
    assert_raises RuntimeError do
      @delve.use_renderer :train
    end
  end

  def test_default_renderer_is_curses
    assert_equal :curses, @delve.renderer
  end

  def test_set_unknown_generator_fails
    assert_raises RuntimeError do
      @delve.use_generator :window
    end
  end

  def test_default_generator_is_rogue
    assert_equal :rogue, @delve.generator
  end

  def test_create_project_fails_if_directory_already_exists
    Dir.expects(:exist?).with(@full_path).returns(true)
    assert_raises RuntimeError do
      @delve.create_game @base_path
    end
  end

  def test_directory_structure_is_created
    Dir.expects(:exist?).with(@full_path).returns(false)
    FileUtils.expects(:mkdir).with(@full_path)
    FileUtils.expects(:mkdir).with(@full_path + '/bin')
    FileUtils.expects(:mkdir).with(@full_path + '/lib')
    FileUtils.expects(:mkdir).with(@full_path + '/lib/' + @name)

    @delve.create_game @base_path
  end

end
