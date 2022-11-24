require_relative "../app"

RSpec.describe Application do
  def reset_app_table
    seed_sql = File.read("spec/seeds_app.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "app_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_app_table
  end

  it "prints list of all albums" do
    terminal = double(:terminal)

    expect(terminal).to receive(:puts).with("Welcome to the music library manager!")
    expect(terminal).to receive(:puts).with("\n" "What would you like to do?" "\n 1 - List all albums" "\n 2 - List all artists")
    expect(terminal).to receive(:puts).with("Enter your choice:")
    expect(terminal).to receive(:gets).and_return("1")
    expect(terminal).to receive(:puts).with("\nHere is your list of albums:")
    expect(terminal).to receive(:puts).with("* 1 - Doolittle")
    expect(terminal).to receive(:puts).with("* 2 - Surfer Rosa")
    expect(terminal).to receive(:puts).with("* 3 - Waterloo")
    expect(terminal).to receive(:puts).with("* 4 - Super Trouper")
    expect(terminal).to receive(:puts).with("* 5 - Bossanova")
    expect(terminal).to receive(:puts).with("* 6 - Lover")
    expect(terminal).to receive(:puts).with("* 7 - Folklore")
    expect(terminal).to receive(:puts).with("* 8 - I Put a Spell on You")
    expect(terminal).to receive(:puts).with("* 9 - Baltimore")
    expect(terminal).to receive(:puts).with("* 10 - Here Comes the Sun")
    expect(terminal).to receive(:puts).with("* 11 - Fodder on My Wings")
    expect(terminal).to receive(:puts).with("* 12 - Ring Ring")

    app = Application.new("app_test", terminal, AlbumRepository.new, ArtistRepository.new)
    app.run
  end

  it "prints list of all artists" do
    terminal = double(:terminal)

    expect(terminal).to receive(:puts).with("Welcome to the music library manager!")
    expect(terminal).to receive(:puts).with("\n" "What would you like to do?" "\n 1 - List all albums" "\n 2 - List all artists")
    expect(terminal).to receive(:puts).with("Enter your choice:")
    expect(terminal).to receive(:gets).and_return("2")
    expect(terminal).to receive(:puts).with("\nHere is your list of artists:")
    expect(terminal).to receive(:puts).with("* 1 - Pixies")
    expect(terminal).to receive(:puts).with("* 2 - ABBA")
    expect(terminal).to receive(:puts).with("* 3 - Taylor Swift")
    expect(terminal).to receive(:puts).with("* 4 - Nina Simone")

    app = Application.new("app_test", terminal, AlbumRepository.new, ArtistRepository.new)
    app.run
  end
end
