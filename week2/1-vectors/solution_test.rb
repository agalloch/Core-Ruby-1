require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def setup
    @v = Vector2D.new(5, 5)
  end

  def test_x_unit_vector
    assert_equal Vector2D.new(1, 0), Vector2D.e
  end

  def test_y_unit_vector
    assert_equal Vector2D.new(0, 1), Vector2D.j
  end

  def test_vector_dimension
    assert_equal 2, @v.dimension
  end

  def test_vector_length
    @v.x = 6
    @v.y = 8

    assert_equal 10, @v.length
  end

  def test_vector_magnitude
    @v.x = 6
    @v.y = 8

    assert_equal 10, @v.magnitude
  end

  def test_normalize
    x_comp = 9
    y_comp = 10
    sqrt = Math.sqrt(x_comp**2 + y_comp**2)

    @v.x = x_comp
    @v.y = y_comp

    assert_equal Vector2D.new(x_comp / sqrt, y_comp / sqrt), @v.normalize
  end

  def test_vector_to_string
    assert_equal '(5, 5)', @v.to_s
  end

  def test_vector_inspect
    assert_equal "#{@v.class}@#{@v.object_id}:#{@v}", @v.inspect
  end

  def test_vector_sum_positive
    u = Vector2D.new(2, 3)
    assert_equal Vector2D.new(7, 8), @v + u
  end

  def test_vector_sum_negative
    u = Vector2D.new(-4, -8)
    assert_equal Vector2D.new(1, -3), @v + u
  end

  def test_vector_subtract
    u = Vector2D.new(7, 8)
    assert_equal Vector2D.new(-2, -3), @v - u
  end

  def test_multiply_by_scalar
    assert_equal Vector2D.new(45, 45), @v * 9
  end

  def test_divide_by_scalar
    assert_equal Vector2D.new(1, 1), @v / 5
  end
end
