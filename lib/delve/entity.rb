class Entity
  def initialize
    @components = Hash.new
  end

  def has?(component_id)
    @components.keys.include? component_id
  end

  def add(component)
    raise 'Cannot add the same component more than once' if has?(component.id)
    @components[component.id] = component
  end
end
