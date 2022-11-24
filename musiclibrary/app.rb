# file: app.rb

require_relative "./lib/album_repository"
require_relative "./lib/artist_repository"
require_relative "./lib/database_connection"

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"
    menu_selection
    process(@io.gets.chomp)
  end
end

def menu_selection
  @io.puts "\n" "What would you like to do?" "\n 1 - List all albums" "\n 2 - List all artists"
  @io.puts "Enter your choice:"
end

def process(selection)
  case selection
  when "1"
    print_albums
  when "2"
    print_artists
  else
    @io.puts "I dont know what you meant, try again"
  end
end

def print_albums
  @io.puts "\nHere is your list of albums:"
  @album_repository.all.each do |album|
    @io.puts "* #{album.id} - #{album.title}"
  end
end

def print_artists
  @io.puts "\nHere is your list of artists:"
  @artist_repository.all.each_with_index do |artist|
    @io.puts "* #{artist.id} - #{artist.name}"
  end
end

if __FILE__ == $0
  app = Application.new(
    "music_library",
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
