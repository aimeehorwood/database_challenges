require 'album_repository'


RSpec.describe AlbumRepository do

  def reset_albums_table
  seed_sql = File.read("spec/seeds_albums.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "albums_artists_test" })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_albums_table
  end

    it "returns two album titles" do
      albums = AlbumRepository.new
      list_of_albums = albums.all

      expect(list_of_albums.length).to eq(2)

      expect(list_of_albums.first.title).to eq("Louis Armstrong Hits")
      expect(list_of_albums.first.release_year).to eq('1970')
    end
  

   it "returns the single album Louis Armstrong Hits" do
    albums = AlbumRepository.new
    list_of_albums = albums.find(1)

    expect(list_of_albums.title).to eq("Louis Armstrong Hits")
    expect(list_of_albums.release_year).to eq("1970")
    expect(list_of_albums.id).to eq("1")
  end

  it "returns the single album Buzzard Buzzard Buzzard" do
    albums = AlbumRepository.new
    list_of_albums = albums.find(2)

    expect(list_of_albums.title).to eq("Buzzard Buzzard Buzzard")
    expect(list_of_albums.release_year).to eq("2022")
    expect(list_of_albums.id).to eq("2")
  end

  it 'creates a new album' do 
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = '30'
    new_album.release_year = '2021'
    new_album.id = '4' 

   repo.create(new_album)

   all_albums = repo.all

   expect(all_albums).to include(
    have_attributes(
      title: new_album.title, 
      release_year: '2021',
      id: '4',
    )
   )
  end
end
