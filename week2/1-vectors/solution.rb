require 'pry'

class Vector
  def initialize(*coords)
    @coords = coords.flatten
  end

  def dimension
    @coords.size
  end

  def normalize
    self / length
  end

  def length
    Math.sqrt(@coords.map { |x_i| x_i**2 }.reduce(:+))
  end

  def [](index)
    @coords[index]
  end

  def []=(index, value)
    @coords[index] = value
  end

  def ==(other)
    @coords.zip(other.coords).each do |x_i, y_i|
      return false unless x_i.to_f == y_i.to_f
    end

    true
  end

  def +(other)
    res = @coords.zip(other.coords).map { |x_i, y_i| x_i.to_i + y_i.to_i }
    Vector.new res
  end

  def -(other)
    res = @coords.zip(other.coords).map { |x_i, y_i| x_i.to_i - y_i.to_i }
    Vector.new res
  end

  def *(scalar)
    @coords = @coords.map { |x_i| x_i * scalar }
    self
  end

  def /(scalar)
    @coords = @coords.map { |x_i| x_i / scalar unless scalar.zero? }
    self
  end

  alias_method :magnitude, :length

  def inspect
    "#{self.class.name}@#{object_id}:(#{@coords.join(', ')})"
  end

  def to_s
    "(#{@coords.join(', ')})"
  end

  protected

  attr_reader :coords
end

class Vector2D < Vector
  def self.e
    Vector2D.new(1, 0)
  end

  def self.j
    Vector2D.new(0, 1)
  end

  def x
    self[0]
  end

  def x=(value)
    self[0] = value
  end

  def y
    self[1]
  end

  def y=(value)
    self[1] = value
  end
end

class Vector3D < Vector2D
  def self.e
    Vector3D.new(1, 0, 0)
  end

  def self.j
    Vector3D.new(0, 1, 0)
  end

  def self.k
    Vector3D.new(0, 0, 1)
  end

  def z
    self[1]
  end

  def z=(value)
    self[2] = value
  end
end

# class Vector2D
#   attr_accessor :x, :y

#   # The unit vector (1, 0).
#   def self.e
#     Vector2D.new(1, 0)
#   end

#   # The unit vector (0, 1).
#   def self.j
#     Vector2D.new(0, 1)
#   end

#   def initialize(x, y)
#     @x, @y = x, y
#   end

#   def length
#     Math.sqrt [@x, @y].map { |el| el**2 }.inject(:+)
#   end

#   alias_method :magnitude, :length

#   def normalize
#     self / length
#   end

#   def +(other)
#     Vector2D.new(@x + other.x, @y + other.y)
#   end

#   def -(other)
#     Vector2D.new(@x - other.x, @y - other.y)
#   end

#   def ==(other)
#     (@x == other.x) && (@y == other.y)
#   end

#   def *(scalar)
#     @x *= scalar
#     @y *= scalar
#     self
#   end

#   def /(scalar)
#     @x /= scalar unless scalar.zero?
#     @y /= scalar unless scalar.zero?
#     self
#   end

#   def inspect
#     "#{self.class.name}@#{object_id}:#{self}"
#   end

#   def to_s
#     "(#{@x}, #{@y})"
#   end
# end
