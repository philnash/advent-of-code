def fuel_required(mass)
  mass // 3 - 2
end

def total_module_fuel_required(mass)
  current_mass = mass
  current_fuel_required = 0
  next_fuel_required = fuel_required(current_mass)
  until next_fuel_required <= 0
    current_fuel_required += next_fuel_required
    next_fuel_required = fuel_required(next_fuel_required)
  end
  current_fuel_required
end