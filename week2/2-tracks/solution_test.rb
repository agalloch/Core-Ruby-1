require 'minitest/autorun'
require 'yaml'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def setup
    @expected_artist = 'KAYTRANADA feat. Shay Lia'
    @expected_name = 'Leave me alone'
    @expected_album = 'So Bad'
    @expected_genre = 'Dance'
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

    assert_match /key not found:/, err.message
  end

  def test_load_from_yaml
    playlist = Playlist.from_yaml('playlist.yml')

    assert_equal YAML.load_file('playlist.yml').size, playlist.length
  end
end
