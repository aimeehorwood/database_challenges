# file: app.rb

require_relative "lib/database_connection"
require_relative "lib/album_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect("music_library")

# Perform a SQL query on the database and get the result set.
sql = "SELECT title FROM albums;"
result = DatabaseConnection.exec_params(sql, [])

album = AlbumRepository.new

album.all.each do |album|
  puts album
end
