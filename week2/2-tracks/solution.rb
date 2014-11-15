require 'yaml'
require 'pry'

class Track
  attr_accessor :artist, :name, :album, :genre

  def initialize(*details, **options)
    if details.empty?
      @artist = options.fetch(:artist)
      @name = options.fetch(:name)
      @album = options.fetch(:album)
      @genre = options.fetch(:genre)
    else
      @artist, @name, @album, @genre = details
    end
  end
end

class Playlist
  def self.from_yaml(path)
    fail ArgumentError unless path

    tracks = YAML.load_file(path)
    Playlist.new(*tracks)
  end

  def initialize(*tracks)
    @playlist = tracks
  end

  def each
    @playlist.each
  end

  def find(&block)
    res = []
    each do |track|
      res << track if yield(track)
    end
    Playlist.new(*res)
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.
  end

  def find_by_name(name)
    # Filter the playlist by a block. Should return a new Playlist.
  end

  def find_by_artist(artist)
    # Finds all the tracks by the artist
  end

  def find_by_album(album)
    # Finds all the tracks from the album.
  end

  def find_by_genre(genre)
    # Finds all the tracks by genre.
  end

  def shuffle
    # Give me a new playlist that shuffles the tracks of the current one.
  end

  def random
    # Give me a random track.
  end

  def to_s
    # It should return a nice tabular representation of all the tracks.
    # Checkout the String method for something that can help you with that.
  end

  def &(other)
    # Your code goes here. This _should_ return new playlist.
  end

  def |(other)
    # Your code goes here. This _should_ return new playlist.
  end

  def -(other)
    # Your code goes here. This _should_ return new playlist.
  end

  def length
    @playlist.size if @playlist
  end
end

class HashWithIndifferentAccess < Hash
end

class Hash
  def with_indifferent_access
    HashWithIndifferentAccess.new(self)
  end
end
