# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
  if index >= 0 && index <= 8
    value = board[index]
    if value == "" || value == " " || value == nil
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    puts "Enter a valid move"
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == 'X' || token == 'O'
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    'X'
  else
    'O'
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |indexes|
    ["X", "O"].any? do |c|
      indexes.all?{|i| board[i]==c}
    end
  end
end

def full?(board)
  board.none?{|c| c == " "}
end

def draw?(board)
  full?(board) and won?(board) == nil
end

def over?(board)
  won?(board) or draw?(board) or full?(board)
end

def winner(board)
  winner = won?(board)
  if winner == nil
    nil
  else
    board[winner[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
