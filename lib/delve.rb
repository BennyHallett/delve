class Delve

  def initialize(name)
    raise 'Cannot create a new roguelike without a name' unless name

    @name = name
  end

end
