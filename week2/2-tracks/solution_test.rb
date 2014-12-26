require 'minitest/autorun'
require 'yaml'
require 'pry'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def setup
    @expected_artist = 'KAYTRANADA feat. Shay Lia'
    @expected_name = 'Leave me alone'
    @expected_album = 'So Bad'
    @expected_genre = 'Dance'

    @playlist = Playlist.from_yaml('playlist.yml')
  end

  def test_track_init_from_list
    track = Track.new @expected_artist, @expected_name, @expected_album,
                      @expected_genre

    assert_equal @expected_artist, track.artist
    assert_equal @expected_name, track.name
    assert_equal @expected_album, track.album
    assert_equal @expected_genre, track.genre
  end

  def test_track_init_from_key_value
    track = Track.new artist: @expected_artist,
                      name:   @expected_name,
                      album:  @expected_album,
                      genre:  @expected_genre

    assert_equal @expected_artist, track.artist
    assert_equal @expected_name, track.name
    assert_equal @expected_album, track.album
    assert_equal @expected_genre, track.genre
  end

  def test_track_raises_error_on_invalid_input
    err = assert_raises KeyError do
      Track.new artist: @expected_artist
    end

    assert_match(/key not found:/, err.message)
  end

  def test_load_from_yaml
    expected = YAML.load_file('playlist.yml')
    assert_playlist_equal(expected, @playlist)
  end

  def test_random
    track1 = @playlist.random
    track2 = @playlist.random
    assert_equal false, track1 == track2, 'Random tracks are equal'
  end

  def test_shuffle
    shuffled = @playlist.shuffle
    # binding.pry
    assert_equal false, @playlist == shuffled
  end

  def test_find
    assert_equal 4, @playlist.find { |track| ['heavy metal', 'trip hop'].include? track.genre.downcase }.length
  end

  def test_find_by_name
    assert_equal 2, @playlist.find_by_name('Clint Eastwood').length
    assert_equal 1, @playlist.find_by_name('King Of My Castle').length
  end

  def test_find_by_artist
    assert_equal 2, @playlist.find_by_artist('Iron Maiden').length
    assert_equal 1, @playlist.find_by_artist('Wamdue Project').length
  end

  def test_find_by_album
    assert_equal 2, @playlist.find_by_album('The Number Of the Beast').length
    assert_equal 1, @playlist.find_by_album('Program yourself').length
  end

  def test_find_by_genre
    assert_equal 2, @playlist.find_by_genre('heavy metal').length
    assert_equal 1, @playlist.find_by_genre('jazz').length
  end

  def test_find_by
  end

  private

  def assert_playlist_equal(expected, playlist)
    assert_equal expected.size, playlist.length, 'Playlist size is wrong'

    playlist.each do |t|
      assert_equal true, expected.include?(t.to_s),
                   "Track #{t} is not expected"
    end
  end
end
