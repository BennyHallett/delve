class Delve

  def initialize(name)
    raise 'Cannot create a new roguelike without a name' unless name
    @name = name

    @renderers = [:curses]
    @generators = [:noise, :rogue, :cellular]
    @renderer = :curses
    @generator = :rogue
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

end
