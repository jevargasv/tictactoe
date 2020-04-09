#!/usr/bin/env ruby
require './lib/board.rb'
require './lib/player.rb'

class Gamels
  def board_draw(board)
    puts " #{board[1]} | #{board[2]} | #{board[3]}",
         '-' * 11,
         " #{board[4]} | #{board[5]} | #{board[6]}",
         '-' * 11,
         " #{board[7]} | #{board[8]} | #{board[9]}"
  end
  
  def valid?(name)
    return true if name.match(/[\w]{2,}/)
  
    false
  end
  
  def save(movement, player)
    player.save_play(movement.to_i)
    Board.update_cell(movement.to_i, player.symb)
  end
  
  def retry_input(player)
    system 'clear'
    board_draw(Board.board)
    puts "\nThe selected cell is either busy or doesn\'t exist."
    get_movement(player)
  end
  
  def continue
    system 'clear'
    board_draw(Board.board)
  end
  
  def request_new
    puts 'Please enter a number from 1 to 9'
    sleep 3
  end
  
  def get_movement(player)
    movement = ''
    loop do
      puts "\n#{player.name}, your symbol is: #{player.symb}"
      print 'Select a valid cell by entering the cell number: '
      movement = gets.chomp
      valid = false
      if movement.match(/\d+/)
        if Board.valid_move?(movement.to_i)
          valid = true
          save(movement, player)
        else
          retry_input(player)
          break
        end
      else
        request_new
      end
      break if valid
  
      continue
    end
  end

  def welcome_screen
    system 'clear'
    puts 'W E L C O M E    T O   T I C T A C T O E!'
    sleep 2
    system 'clear'
  end

  def get_name(number)
    name=""
    loop do
      system 'clear'
      puts "@What is your name PLAYER #{number}?"
      name = gets.chomp
      break if valid?(name)
    end
    return name
  end  
    
  def game_cycle
    welcome_screen
    name=get_name(1)
    player1 = Player.new(name, 1)
    name=get_name(2)
    player2 = Player.new(name, 2)
    sleep 1
    system 'clear'
    Board.create_board
    i = 0 # counter to control left cells
    winner = nil
    loop do
      board_draw(Board.board)
      get_movement(player1)
      winner = player1.name if Board.win?(player1.played_cells)
      i += 1
      break if winner == player1.name || i == 9
    
      sleep 1
      system 'clear'
    
      board_draw(Board.board)
      get_movement(player2)
      winner = player2.name if Board.win?(player2.played_cells)
      i += 1
      break if winner == player2.name || i == 9
    
      sleep 1
      system 'clear'
    end
    
    system 'clear'
    board_draw(Board.board)
    puts "\n#{winner.upcase} JUST WON THE GAME!" if winner
    puts "\nGAME OVER! It\'s a tie" if i == 9 && !winner
  
  end
   
end


#run_game=Gamels.new
#run_game.game_cycle
