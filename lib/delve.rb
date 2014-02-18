require 'fileutils'
require 'erb'

class Delve

  def initialize(name)
    raise 'Cannot create a new roguelike without a name' unless name
    @name = name

    @renderers = [:curses]
    @generators = [:noise, :rogue, :cellular]
    @renderer = :curses
    @generator = :rogue

    @statements = {
      :curses => {
        :renderer     => 'delve/renderer/curses',
        :input        => 'delve/input/curses',
        :new_renderer => 'CursesRenderer.new',
        :new_input    => 'CursesInput.new'
      }
    }
  end

  def use_renderer(renderer)
    raise "Cannot use unknown renderer: #{renderer}" unless @renderers.include? renderer
    @renderer = renderer
  end

  def use_generator(generator)
    raise "Cannot use unknown generator: #{generator}" unless @generators.include? generator
    @generator = generator
  end

  def renderer
    @renderer
  end

  def generator
    @generator
  end

  def create_game path
    raise "Cannot create roguelike when path already exists: #{path}/#{@name}" if Dir.exist?("#{path}/#{@name}")

    @base_path = File.join(path, @name).to_s
    create_directories
    create_gem_files
    create_bin_file
  end

  private
  def create_bin_file
    @renderer_import        = @statements[@renderer][:renderer]
    @input_import           = @statements[@renderer][:input]
    @new_renderer_statement = @statements[@renderer][:new_renderer]
    @new_input_statement    = @statements[@renderer][:new_input]

    create_file_from_template 'binfile.erb', "bin/#{@name}.rb"
  end

  def create_gem_files
    create_file_from_template 'Gemfile.erb', 'Gemfile'
    create_file_from_template 'gemspec.erb', "#{@name}.gemspec"
    create_file_from_template 'README.md.erb', "README.md"
  end

  def create_file_from_template(template_name, target)
    dir = File.expand_path(File.dirname(__FILE__))
    content = File.read(File.join(dir, "../templates/#{template_name}"))
    erb = ERB.new content
    File.open(File.join(@base_path, target), 'w') do |file|
      file.write erb.result(binding)
    end
  end

  def create_directories
    FileUtils.mkdir(@base_path)
    FileUtils.mkdir(@base_path + '/bin')
    FileUtils.mkdir(@base_path + '/lib')
    FileUtils.mkdir(@base_path + '/lib/' + @name)
  end

end
