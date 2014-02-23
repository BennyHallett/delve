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
        :renderer       => 'delve/display/curses_renderer',
        :input          => 'delve/input/curses_input',
        :new_renderer   => 'CursesRenderer.new',
        :new_input      => 'CursesInput.new'
      },
      :noise => {
        :generator      => 'delve/generator/noise',
        :new_generator  => 'NoiseGenerator.new(256, 128, :fine)'
      },
      :rogue => {
        :generator      => 'delve/generator/rogue',
        :new_generator  => 'RogueGenerator.new(256, 128)'
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
    create_screens
    create_game_classes
  end

  private
  def create_game_classes
    create_file_from_template 'world.rb.erb', "lib/#{@name}/world.rb"
    create_file_from_template 'player_factory.rb.erb', "lib/#{@name}/factory/player.rb"
  end

  def create_screens
    @generator_import       = @statements[@generator][:generator]
    @new_generator          = @statements[@generator][:new_generator]
    create_file_from_template 'title_screen.rb.erb', "lib/#{@name}/screens/title.rb"
    create_file_from_template 'loading_screen.rb.erb', "lib/#{@name}/screens/loading.rb"
    create_file_from_template 'game_screen.rb.erb', "lib/#{@name}/screens/game.rb"
  end

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
    FileUtils.mkdir(@base_path + '/lib/' + @name + '/screens')
    FileUtils.mkdir(@base_path + '/lib/' + @name + '/factory')
  end

end
