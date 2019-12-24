class OrbitMap
  getter objects : Set(OrbitingObject)
  def initialize(relationships : Array(String))
    @objects = Set(OrbitingObject).new
    relationships.each do |relationship|
      object_a_name, object_b_name = relationship.split(")")
      object_a = find_or_create(object_a_name)
      object_b = find_or_create(object_b_name)
      object_b.add_direct_orbit(object_a)
      object_a.add_orbitted_by(object_b)
    end
  end

  def find(name)
    @objects.find { |object| object.name == name }
  end

  def find_or_create(name)
    object = find(name)
    return object unless object.nil?
    if name === "COM"
      object = COMObject.new(name)
    else 
      object = OrbitingObject.new(name)
    end
    @objects.add(object)
    return object
  end

  def check_sum
    objects.map { |object| object.name == "COM" ? 0 : 1 + object.indirect_orbits.size }.sum
  end

  def distance_between(name_a, name_b)
    object_a = find(name_a)
    object_b = find(name_b)
    raise "Object #{name_a} not found." if object_a.nil?
    raise "Object #{name_b} not found." if object_b.nil?
    checked_objects = Set(OrbitingObject).new([object_a])
    objects_to_check = Array(Tuple(OrbitingObject, Int32)).new
    objects_to_check.concat(object_a.orbitted_by.map { |o| {o, 0} })
    direct_orbit = object_a.directly_orbits
    objects_to_check.push({direct_orbit, 0}) if direct_orbit
    while !objects_to_check.empty?
      object, count = objects_to_check.shift
      return count - 1 if object == object_b
      checked_objects.add(object)
      direct_orbit = object.directly_orbits
      if !direct_orbit.nil? && !checked_objects.includes?(direct_orbit)
        objects_to_check.push({direct_orbit, count+1})
      end
      object.orbitted_by.each do |o|
        objects_to_check.push({o, count+1}) if !checked_objects.includes?(o)
      end
    end
  end
end 

class OrbitingObject
  getter directly_orbits : OrbitingObject | Nil
  getter name : String
  getter orbitted_by : Array(OrbitingObject)
  def initialize(@name)
    @directly_orbits = nil
    @orbitted_by = [] of OrbitingObject
  end

  def add_direct_orbit(object : OrbitingObject)
    @directly_orbits = object
  end

  def add_orbitted_by(object : OrbitingObject)
    @orbitted_by.push(object)
  end
  
  def indirect_orbits
    objects = Set(OrbitingObject).new
    direct_orbit = directly_orbits
    return objects if direct_orbit.nil?
    current_object = direct_orbit.directly_orbits
    return objects if current_object.nil?
    while !current_object.nil?
      objects.add(current_object)
      current_object = current_object.directly_orbits
    end
    return objects
  end
end

class COMObject < OrbitingObject
  def directly_orbits
    nil
  end
  def indirect_orbits
    return Set(OrbitingObject).new
  end
end