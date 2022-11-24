require 'artist_repository'


RSpec.describe ArtistRepository do

  def reset_artists_table
  seed_sql = File.read("spec/seeds_artists.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "albums_artists_test" })
  connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end

  it "returns all artists" do
    repo = ArtistRepository.new
    artists_details = repo.all
    expect(artists_details.length).to eq(2)
    expect(artists_details.first.name).to eq("John Legend")
    expect(artists_details.first.genre).to eq("R&B")
  end
end 