require_relative "./artist"

class ArtistRepository
    def all
      sql = "SELECT id, name, genre FROM artists;"
      result_set = DatabaseConnection.exec_params(sql, [])
  
      artists_list = []
  
      result_set.each do |artist|
        artists_all = Artist.new
        artists_all.id = artist["id"]
        artists_all.name = artist["name"]
        artists_all.genre = artist["genre"]
  
        artists_list << artists_all
      end
  
      return artists_list
    end
end