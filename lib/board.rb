# rubocop: disable Style/ClassVars

class Board
  @@board = {}
  @@win_combos = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  def self.create_board
    (1..9).each do |i|
      @@board[i] = i.to_s
    end
  end

  def self.exists?(value)
    if value.is_a? Integer
      value.positive? && value < 10
    else
      false
    end
  end

  def self.busy?(value)
    @@board[value] == 'X' || @@board[value] == 'O'
  end

  def self.valid_move?(movement)
    valid = Board.exists?(movement.to_i)
    valid ? !Board.busy?(movement.to_i) : false
  end

  def self.win?(played)
    result = false
    i = 1
    loop do
      result = (@@win_combos[i - 1] - played).empty?
      i += 1
      break if result == true || i == @@win_combos.length + 1
    end
    result
  end

  def self.update_cell(value, symb)
    @@board[value] = symb
  end

  def self.board
    @@board
  end
end
# rubocop: enable Style/ClassVars
