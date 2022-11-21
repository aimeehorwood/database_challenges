require_relative 'album'

class AlbumRepository
  def all
    sql = "SELECT title FROM albums;"
    result_set = DatabaseConnection.exec_params(sql,[])

    albums_list = []

    result_set.each do |album|
      album_one = Album.new
     # album_one.id = album["id"]
      album_one.title = album["title"]
     # album_one.release_year = album["release_year"]

      albums_list << album_one.title
    end

    return albums_list
  end
end