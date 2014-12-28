require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def setup
    @board = GameOfLife::Board.new [1, 1]
  end

  def test_membership
    assert_equal true, @board[1, 1]
  end

  def test_count
    assert_equal 1, @board.count
  end

  def test_generation_after_tick
    board = GameOfLife::Board.new [0, 0], [1, 1], [1, 0], [5, 7]
    next_gen = board.next_generation

    assert_equal 4, next_gen.count
    assert_equal false, next_gen[5, 7]
  end

  def test_generation_after_two_ticks
    board = GameOfLife::Board.new [0, 0], [1, 1], [1, 0], [5, 7]
    next_gen = board.next_generation.next_generation

    assert_equal 4, next_gen.count
    assert_equal false, next_gen[5, 7]
  end

  def test_cell_lives
    x, y = 0, 0
    board = GameOfLife::Board.new [x, y], [1, 1], [-1, -1]
    assert_equal true, board.next_generation[x, y]
  end

  def test_newborn_cell
    board = GameOfLife::Board.new [1, 1], [-1, -1], [-1, 1]
    assert_equal true, board.next_generation[0, 0]
  end
end
