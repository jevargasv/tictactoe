require_relative '../lib/board.rb'

RSpec.describe Board do
  let(:board) { Board.board }
  describe '.create_board' do
    it 'creates a board hash with keys and values' do
      Board.create_board
      expect(Board.board).to be_a(Hash)
    end
  end

  describe '.board' do
    it 'the board contains keys and values from 1 to 9' do
      expect(board).to include((1..9))
    end

    it 'the board length is 9' do
      expect(board.length).to eql(9)
    end
  end

  describe '.exists?' do
    it 'returns true if the passed cell exists in the board' do
      cell = 1
      expect(Board.exists?(cell)).to eql(true)
    end

    it 'returns false if the passed cell doesn\'t exist in the board' do
      cell = 10
      expect(Board.exists?(cell)).to eql(false)
    end
  end

  describe '.busy?' do
    it 'returns true if cell is busy' do
      Board.create_board
      Board.update_cell(1, 'X')
      expect(Board.busy?(1)).to eql(true)
    end

    it 'returns false if cell is not busy' do
      Board.create_board
      expect(Board.busy?(1)).to eql(false)
    end
  end

  describe '.valid_move?' do
    it 'retuns true if the cell passed is not busy and it exists' do
      Board.create_board
      expect(Board.valid_move?(1)).to eql(true)
    end

    it 'retuns false if the cell passed is busy and it exists' do
      Board.create_board
      Board.update_cell(1, 'X')
      expect(Board.valid_move?(1)).to eql(false)
    end

    it 'retuns false if the cell passed does not exists' do
      Board.create_board
      expect(Board.valid_move?(10)).to eql(false)
    end
  end
end