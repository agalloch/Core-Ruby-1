require 'set'
require 'pry'

module GameOfLife
  class Board
    include Enumerable

    def initialize(*cells)
      @cells = Set.new cells.map { |cell| Cell.new cell }
    end

    def next_generation
      list = []
      each do |cell|
        list << cell if cell.lives? @cells
        cell.neighbours.each { |n| list << n if n.newborn? @cells }
      end

      Board.new(*list)
    end

    def [](*cell)
      each.include? Cell.new cell
    end

    def each(&block)
      @cells.each(&block)
    end

    def count
      each.count
    end
  end

  class Cell
    attr_reader :x, :y

    def initialize(*cell)
      @x, @y = cell.flatten
    end

    def neighbours
      return @n if @n

      @adjacent_coords =
        [x + 1, x, x - 1].product([y + 1, y, y - 1]).select! { |c| c != to_ary }
      @n = Set[*@adjacent_coords.map { |c| Cell.new c }]
    end

    def lives?(cells)
      (2..3).include?((cells & neighbours).size) && cells.include?(self)
    end

    def newborn?(cells)
      (cells & neighbours).size == 3 && !cells.include?(self)
    end

    def to_ary
      [@x, @y]
    end

    def hash
      [@x, @y].hash
    end

    def eql?(other)
      @x == other.x && @y == other.y
    end

    alias_method :==, :eql?
  end
end
