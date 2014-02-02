class Entity
  def initialize
    @components = Hash.new
  end

  def has?(component_id)
    @components.keys.include? component_id
  end

  def add_component(component)
    @components[component.id] = component
  end
end
