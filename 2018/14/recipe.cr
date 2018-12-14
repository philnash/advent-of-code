
class Recipe
  def self.next_ten(after : String)
    after = after.to_i
    recipe_list = [3, 7]

    elf1 = 0
    elf2 = 1

    while recipe_list.size < after + 10
      recipe_list, elf1, elf2 = next_recipes(recipe_list, elf1, elf2)
    end
    return recipe_list[after...after+10].join("")
  end

  def self.how_many_to_score(score : String)
    pattern = score.split("").map(&.to_i)
    size = pattern.size
    recipe_list = [3, 7]
    elf1 = 0
    elf2 = 1

    while recipe_list.size < size+1
      recipe_list, elf1, elf2 = next_recipes(recipe_list, elf1, elf2)
    end
    while recipe_list[-size..-1] != pattern && recipe_list[-(size+1)..-2] != pattern
      recipe_list, elf1, elf2 = next_recipes(recipe_list, elf1, elf2)
    end
    recipe_string = recipe_list.join("")
    return recipe_string.index(score)
  end

  def self.next_recipes(list, elf1, elf2)
    combine = list[elf1] + list[elf2]
    if combine < 10
      list.push(combine)
    else
      list.push(combine / 10 % 10).push(combine % 10)
    end
    elf1 = (elf1 + list[elf1] + 1) % list.size
    elf2 = (elf2 + list[elf2] + 1) % list.size
    {list, elf1, elf2}
  end
end