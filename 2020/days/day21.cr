def parse(input : String)
  potential_allergens = Hash(String, Set(String)).new
  all_ingredients = Hash(String, Int32).new
  input.split("\n").each do |line|
    ingredients = line.split(" ").take_while { |ing| !ing.starts_with?("(") }.to_set
    ingredients.each do |ing|
      if all_ingredients.has_key?(ing)
        all_ingredients[ing] += 1
      else
        all_ingredients[ing] = 1
      end
    end
    allergens = line.gsub(")", "").split("contains ").last.split(", ")
    allergens.each do |allergen|
      if potential_allergens.has_key?(allergen)
        potential_allergens[allergen] = potential_allergens[allergen] & ingredients
      else
        potential_allergens[allergen] = ingredients
      end
    end
  end
  all_allergens = potential_allergens.values.reduce(potential_allergens.values.first) { |acc, set| acc + set }
  safe = all_ingredients.keys.to_set - all_allergens
  puts safe.map { |ing| all_ingredients.fetch(ing, 0) }.sum

  actual_allergens = Hash(String, String).new
  while !potential_allergens.empty?
    potential_allergens.keys.each do |allergen|
      if potential_allergens[allergen].size == 1
        ingredient = potential_allergens[allergen].first
        actual_allergens[allergen] = ingredient
        potential_allergens.delete(allergen)
        potential_allergens.keys.each do |al|
          if potential_allergens[al].includes?(ingredient)
            potential_allergens[al] = potential_allergens[al].delete(ingredient)
          end
        end
      end
    end
  end
  puts actual_allergens.to_a.sort_by { |(al, ing)| al }.map { |(al, ing)| ing }.join(",")
end

input = "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)"

input = File.read("./days/day21.txt")
puts parse(input)
