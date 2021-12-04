module Bingo
  class Game
    @draws : Array(Int32)
    @boards : Array(Board)

    def initialize(input : String)
      split_by_lines = input.split(/\n\n/)
      @draws = split_by_lines.shift.split(",").map(&.to_i)
      @boards = split_by_lines.map { |board_input| Board.new(board_input) }
    end

    def play
      winner = nil
      @draws.each do |number|
        @boards.each do |board|
          board.play(number)
          if board.has_won?
            winner = board
            break
          end
        end
        break if winner
      end
      return winner.score if winner
    end

    def play_until_last_board_wins
      winners = [] of Board
      boards = @boards.dup
      @draws.each do |number|
        boards.each do |board|
          next if winners.includes?(board)
          board.play(number)
          winners.push(board) if board.has_won?
        end
        break if winners.size == @boards.size
      end
      return winners.last.score if winners.any?
    end
  end

  class Board
    getter rows : Array(Array(Int32))
    getter columns : Array(Array(Int32))

    def initialize(input : String)
      @numbers = Array(Int32).new
      @rows = input.split(/\n/).map { |line| line.split(/\s+/).reject { |s| s == "" }.map { |digits| digits.strip.to_i } }
      @columns = [] of Array(Int32)
      @rows.first.size.times do |column|
        @columns.push(@rows.map { |row| row[column] })
      end
    end

    def play(number : Int32)
      @numbers.push(number) if @rows.flatten.includes?(number)
    end

    def has_won?
      (@rows + @columns).any? do |line|
        (line & @numbers).size == 5
      end
    end

    def score
      (@rows.flatten - @numbers).sum * @numbers.last
    end
  end
end
