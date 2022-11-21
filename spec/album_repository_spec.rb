require 'album_repository'

RSpec.describe AlbumRepository do

def reset_albums_table
  seed_sql = File.read("spec/seeds_albums.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "albums_test" })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_albums_table
  end

  context "all method" do
    it "returns a list of all the album titles" do
      albums = AlbumRepository.new
      list_of_albums = albums.all
      expect(list_of_albums.length).to eq 2
    end
  end

  it "returns all albums"  do
    albums = AlbumRepository.new
    list_of_albums = albums.all
    expect(list_of_albums).to eq ["Louis Armstrong Hits", "Buzzard Buzzard Buzzard"]
  end 
end



#list_of_albums[0].id # =>  1
#list_of_albums[0].title # =>  'Louis Armstrong Hits'
#list_of_albums[0].release_year # =>  1970

#list_of_albums[1].id # =>  2
#list_of_albums[1].title # =>  'Buzzard Buzzard Buzzard'
#list_of_albums[1].release_year # =>  2022
  


#albums = AlbumsRepository.new

#list_of_album = albums.all

#list_of_albums.length # =>  2

#list_of_albums[0].id # =>  1
#list_of_albums[0].title # =>  'Louis Armstrong Hits'
#list_of_albums[0].release_year # =>  1970

#list_of_albums[1].id # =>  2
#list_of_albums[1].title # =>  'Buzzard Buzzard Buzzard'
#list_of_albums[1].release_year # =>  2022