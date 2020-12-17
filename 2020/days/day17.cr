class ConwayCubes
  getter layers : Array(Array(Array(Bool)))

  def initialize(input : String)
    @layers = [input.split("\n").map { |line| line.split("").map { |cube| cube == "#" } }]
  end

  def print
    puts @layers.map_with_index { |layer, z|
      "layer #{z}\n" + layer.map { |line|
        line.map { |cube| cube ? "#" : "." }.join("")
      }.join("\n")
    }.join("\n\n")
  end

  def cycle
    new_width = @layers.first.size + 2
    @layers.each { |layer|
      layer.each { |line|
        line.unshift(false).push(false)
      }
      layer.unshift(Array(Bool).new(new_width, false)).push(Array(Bool).new(new_width, false))
    }
    @layers.push(Array(Array(Bool)).new(new_width, Array(Bool).new(new_width, false))).unshift(Array(Array(Bool)).new(new_width, Array(Bool).new(new_width, false)))

    coords = (-1..1).flat_map { |z| (-1..1).flat_map { |y| (-1..1).map { |x| [x, y, z] } } }.reject { |coords| coords == [0, 0, 0] }
    @layers = @layers.map_with_index { |layer, z|
      layer.map_with_index { |line, y|
        line.map_with_index { |cube, x|
          active_neighbours = coords.map { |coord|
            begin
              @layers[z + coord[2]][y + coord[1]][x + coord[0]]
            rescue
              false
            end
          }
          active_neighbours = active_neighbours.count(true)
          if @layers[z][y][x] && !(active_neighbours == 2 || active_neighbours == 3)
            false
          elsif !@layers[z][y][x] && active_neighbours == 3
            true
          else
            @layers[z][y][x]
          end
        }
      }
    }
    self
  end

  def count
    @layers.flat_map { |layer| layer.flat_map { |line| line.flat_map { |cube| cube ? 1 : 0 } } }.sum
  end
end

class ConwayCubes4D
  getter dimensions : Array(Array(Array(Array(Bool))))

  def initialize(input : String)
    @dimensions = [[input.split("\n").map { |line| line.split("").map { |cube| cube == "#" } }]]
  end

  def cycle
    new_width = @dimensions.first.first.size + 2
    @dimensions.each { |dim|
      dim.each { |layer|
        layer.each { |line|
          line.unshift(false).push(false)
        }
        layer
          .unshift(Array(Bool).new(new_width, false))
          .push(Array(Bool).new(new_width, false))
      }
      dim.push(
        Array(Array(Bool)).new(new_width,
          Array(Bool).new(new_width, false)
        )
      ).unshift(
        Array(Array(Bool)).new(new_width,
          Array(Bool).new(new_width, false)
        )
      )
    }
    @dimensions.push(
      Array(Array(Array(Bool))).new(new_width,
        Array(Array(Bool)).new(new_width,
          Array(Bool).new(new_width, false)
        )
      )
    ).unshift(
      Array(Array(Array(Bool))).new(new_width,
        Array(Array(Bool)).new(new_width,
          Array(Bool).new(new_width, false)
        )
      )
    )

    coords = (-1..1).flat_map { |w| (-1..1).flat_map { |z| (-1..1).flat_map { |y| (-1..1).map { |x| [x, y, z, w] } } } }.reject { |coords| coords == [0, 0, 0, 0] }
    @dimensions = @dimensions.map_with_index { |dim, w|
      dim.map_with_index { |layer, z|
        layer.map_with_index { |line, y|
          line.map_with_index { |cube, x|
            active_neighbours = coords.map { |coord|
              begin
                @dimensions[w + coord[3]][z + coord[2]][y + coord[1]][x + coord[0]]
              rescue
                false
              end
            }
            active_neighbours = active_neighbours.count(true)
            if @dimensions[w][z][y][x] && !(active_neighbours == 2 || active_neighbours == 3)
              false
            elsif !@dimensions[w][z][y][x] && active_neighbours == 3
              true
            else
              @dimensions[w][z][y][x]
            end
          }
        }
      }
    }
    self
  end

  def count
    @dimensions.flat_map { |dim| dim.flat_map { |layer| layer.flat_map { |line| line.flat_map { |cube| cube ? 1 : 0 } } } }.sum
  end
end
