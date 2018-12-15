class Game
  getter last_value : Int64
  getter num_players : Int32
  getter current_marble : Marble
  getter players : Array(Player)

  def initialize(@last_value, @num_players)
    @current_marble = Marble.new(0)
    @current_marble.clockwise = @current_marble
    @current_marble.anticlockwise = @current_marble
    @players = [] of Player
    @num_players.times { @players.push(Player.new) }
    @current_player_index = 0
    @current_marble_number = 1
  end

  def play
    while @current_marble_number < @last_value + 1
      if @current_marble_number % 23 == 0
        marble = @current_marble.retreat(7).not_nil!
        @current_marble = marble.clockwise.not_nil!
        marble.remove
        @players[@current_player_index].add(@current_marble_number)
        @players[@current_player_index].add(marble.number)
        @current_marble_number += 1
        @current_player_index += 1
      else
        marble = @current_marble.advance(1).not_nil!
        new_marble = Marble.new(@current_marble_number)
        new_marble.insert_after(marble)
        @current_marble = new_marble
        @current_marble_number += 1
        @current_player_index = (@current_player_index + 1) % @num_players
      end
    end
    @players.map(&.score).max
  end
end

class Player
  getter score : Int64

  def initialize
    @score = 0.to_i64
  end

  def add(new_score)
    @score += new_score
  end
end

class Marble
  property anticlockwise : Marble | Nil
  property clockwise : Marble | Nil
  getter number : Int32

  def initialize(@number)
  end

  def advance(times : Int32)
    marble = self
    while times > 0 && marble && marble.clockwise
      marble = marble.clockwise
      times = times - 1
    end
    marble
  end

  def retreat(times : Int32)
    marble = self
    while times > 0 && marble && marble.anticlockwise
      marble = marble.anticlockwise
      times = times - 1
    end
    marble
  end

  def insert_after(marble : Marble)
    next_marble = marble.clockwise.not_nil!
    marble.clockwise = self
    next_marble.anticlockwise = self
    self.clockwise = next_marble
    self.anticlockwise = marble
  end

  def remove
    clockwise.not_nil!.anticlockwise = anticlockwise
    anticlockwise.not_nil!.clockwise = clockwise
  end
end