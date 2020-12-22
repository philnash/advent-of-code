module Combat
  class RecursiveGame
    @players : Array(Player)
    getter game_number : Int32
    @previous_rounds : Set(Array(Array(Int32)))

    def self.parse(input : String)
      players = input.split("\n\n")
      players = players.map { |player|
        lines = player.split("\n")
        name = lines.first
        cards = lines[1..-1].map(&.to_i)
        Player.new(name, cards)
      }
      new(players, 1)
    end

    def initialize(@players : Array(Player), @game_number : Int32)
      @previous_rounds = Set(Array(Array(Int32))).new
    end

    def play
      round = 1
      while @players.all?(&.playing?)
        if @previous_rounds.includes?(@players.map(&.cards))
          puts "#{@players.first.name} wins the round because it's the same hand"
          return @players
        end
        @previous_rounds.add(@players.map { |p| p.cards.dup })
        plays = @players.map { |player| {player, player.play_hand} }
        if plays.all? { |(p, c)| c <= p.cards.size }
          winner, loser = Combat::RecursiveGame.new(plays.map { |(p, c)| p.copy(c) }, @game_number + 1).play
          this_rounds_winner = plays.find({plays.first[0], -1}) { |(p, c)| p == winner }[0]
          this_rounds_winner.receive_cards([plays.find({winner, -1}) { |(p, c)| p == winner }[1], plays.find({loser, -1}) { |(p, c)| p == loser }[1]])
        else
          winner = plays.max_by { |(p, c)| c }
          loser = plays.reject { |play| play == winner }.first
          winner[0].receive_cards([winner[1], loser[1]])
        end
        round += 1
      end
      winner = @players.select(&.playing?).first
      puts "\n#{winner.name} wins game #{@game_number}!"
      puts "Score: #{score(winner)}"
      return [winner, @players.reject(&.playing?)].flatten
    end

    def score(player)
      player.cards.reverse.zip(1..player.cards.size).map { |(c, v)| c * v }.sum
    end
  end

  class Game
    @players : Array(Player)

    def initialize(input : String)
      players = input.split("\n\n")
      @players = Array(Player).new
      players.each { |player|
        lines = player.split("\n")
        name = lines.first
        cards = lines[1..-1].map(&.to_i)
        @players.push(Player.new(name, cards))
      }
    end

    def play
      round = 1
      while @players.all?(&.playing?)
        puts "Round #{round}"
        @players.each { |p| puts "#{p.name}'s deck: #{p.hand}" }
        plays = @players.map { |player| {player, player.play_hand} }
        plays.each { |(p, c)| puts "#{p.name} plays: #{c}" }
        winner = plays.max_by { |(p, c)| c }
        puts "#{winner[0].name} wins the round!"
        winner[0].receive_cards(plays.map { |(p, c)| c }.sort.reverse)
        round += 1
      end
      winner = @players.select(&.playing?).first
      puts "\n#{winner.name} wins!"
      puts "Score: #{score(winner)}"
    end

    def score(player)
      player.cards.reverse.zip(1..player.cards.size).map { |(c, v)| c * v }.sum
    end
  end

  class Player
    getter name : String
    getter cards : Array(Int32)

    def initialize(@name : String, @cards : Array(Int32))
    end

    def play_hand
      return @cards.shift
    end

    def receive_cards(cards : Array(Int32))
      @cards.concat(cards)
    end

    def playing?
      !@cards.empty?
    end

    def hand
      @cards.join(", ")
    end

    def copy(hand_size = @cards.size)
      Player.new(@name, @cards.first(hand_size))
    end

    def ==(other : Player)
      @name == other.name
    end
  end
end

input = "Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10"

input = File.read("./days/day22.txt")

game = Combat::RecursiveGame.parse(input)
game.play
