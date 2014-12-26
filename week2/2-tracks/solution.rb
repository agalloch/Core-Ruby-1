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
    pairs = [artist, name, album, genre].zip(
      [other.artist, other.name, other.album, other.genre]
    )
    pairs.each do |p|
      this, that = p
      return false if this.downcase != that.downcase
    end

    true
  end

  alias_method :eql?, :==

  def hash
    [artist, name, album, genre].hash
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
    Playlist.new(*each.select { |track| yield(track) })
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.

    proc = lambda do |track|
      res = true
      filters.each do |f|
        res &&= f.call(track)
        return false unless res
      end

      res
    end

    find(&proc)
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

  def &(other)
    Playlist.new(*(@playlist & other.each.to_a))
  end

  def |(other)
    Playlist.new(*(@playlist + other.each.to_a).uniq)
  end

  def -(other)
    Playlist.new(*(@playlist - other.each.to_a))
  end

  def length
    @playlist ? @playlist.size : 0
  end

  def empty?
    length == 0
  end

  def ==(other)
    return false if length != other.length
    other.each.each_with_index do |other_track, index|
      return false if @playlist[index] != other_track
    end
  end

  def to_s
    # It should return a nice tabular representation of all the tracks.
    # Checkout the String method for something that can help you with that.

    max_artist, max_name, max_album, max_genre = 0, 0, 0, 0
    each.each do |t|
      max_artist = [t.artist.length, max_artist].max
      max_name = [t.name.length, max_name].max
      max_album = [t.album.length, max_album].max
      max_genre = [t.genre.length, max_genre].max
    end

    offset = 4 * 2
    delimiters = 4
    max_line = max_artist + max_name + max_album + max_genre + offset +
               delimiters + length.to_s.length

    puts '-' * max_line
    puts 'playlist empty' if empty?

    each.each_with_index do |t, index|
      track_index = format("%0#{length.to_s.length}d", (index + 1))
      puts "#{track_index} #{format_track(t, max_artist, max_name, max_album)}"
    end

    puts '-' * max_line
  end

  private

  def format_track(t, artist_offset, name_offset, album_offset)
    artist = "| #{t.artist}#{' ' * (artist_offset - t.artist.length)} "
    name = "| #{t.name}#{' ' * (name_offset - t.name.length)} "
    album = "| #{t.album}#{' ' * (album_offset - t.album.length)} "
    genre = "| #{t.genre}"
    "#{artist}#{name}#{album}#{genre}"
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
  AWESOME_ARTISTS = %w(Led\ Zeppellin The\ Doors Black\ Sabbath Iron\ Maiden)

  def call(track)
    AWESOME_ARTISTS.include? track.artist
  end
end
