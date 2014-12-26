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

  def ==(other)
    artist.casecmp(other.artist) == 0 &&
      name.casecmp(other.name) == 0 &&
      album.casecmp(other.album) == 0 &&
      genre.casecmp(other.genre)
  end

  def to_s
    { 'artist' => artist, 'name' => name, 'album' => album, 'genre' => genre }
  end
end

class Playlist
  def self.from_yaml(path)
    fail ArgumentError unless path

    tracks = YAML.load_file(path)

    initial_tracks = []
    tracks.each do |tr|
      initial_tracks << Track.new(tr.with_indifferent_access)
    end

    Playlist.new(*initial_tracks)
  end

  def initialize(*tracks)
    @playlist = tracks
  end

  def each(&block)
    @playlist.each(&block)
  end

  def find
    res = each.select { |track| yield(track) }

    Playlist.new(*res)
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.

    find do |track|
      filters.reduce { |filter, memo| memo && filter.call(track) }
    end
  end

  def find_by_name(name)
    find { |track| track.name.downcase == name.downcase }
  end

  def find_by_artist(artist)
    find { |track| track.artist.downcase == artist.downcase }
  end

  def find_by_album(album)
    find { |track| track.album.downcase == album.downcase }
  end

  def find_by_genre(genre)
    find { |track| track.genre.downcase == genre.downcase }
  end

  def shuffle
    Playlist.new(*@playlist.shuffle)
  end

  def random
    while @previous_index == (random_index = rand(@playlist.size))
      random_index = rand(@playlist.size)
    end

    @previous_index = random_index
    @playlist[@previous_index]
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

  def ==(other)
    return false if length != other.length
    other.each.each_with_index do |other_track, index|
      return false if @playlist[index] != other_track
    end
  end
end

class HashWithIndifferentAccess < Hash
  def initialize(hash)
    hash.each { |k, v| self[k.to_sym] = v }
  end

  def fetch(key)
    fetch key.to_sym
  end
end

class Hash
  def with_indifferent_access
    HashWithIndifferentAccess.new(self)
  end
end

class AwesomeRockFilter
  AWESOME_ARTISTS = %w(Led\ Zeppellin The\ Doors Black\ Sabbath)

  def call(track)
    AWESOME_ARTISTS.include? track.artist
  end
end

class AwesomeJazzFilter
  AWESOME_ARTISTS = %w(Louis\ Armstrong Frank\ Sinatra Nina\ Simone)

  def call(track)
    AWESOME_ARTISTS.include? track.artist
  end
end
