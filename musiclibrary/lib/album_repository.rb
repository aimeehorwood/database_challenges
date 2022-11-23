require_relative "./album"

class AlbumRepository
  def all
    sql = "SELECT id, title, release_year FROM albums;"
    result_set = DatabaseConnection.exec_params(sql, [])

    albums_list = []

    result_set.each do |album|
      album_one = Album.new
      album_one.id = album["id"]
      album_one.title = album["title"]
      album_one.release_year = album["release_year"]

      albums_list << album_one
    end

    return albums_list
  end

  def find(id)
    sql = "SELECT id,title,release_year FROM albums WHERE id =$1;"
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    album = Album.new
    album.id = record["id"]
    album.title = record["title"]
    album.release_year = record["release_year"]

    return album
  end

  def create(album)
    sql = "INSERT INTO albums (title,release_year,id) VALUES ($1,$2,$3);"
    sql_params = [album.title, album.release_year, album.id]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
