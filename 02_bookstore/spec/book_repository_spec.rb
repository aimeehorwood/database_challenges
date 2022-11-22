require "book_repository"

RSpec.describe BookRepository do
  def reset_books_table
    seed_sql = File.read("spec/seeds_books.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "book_store_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  context "all method" do
    it "returns a list of all the books" do
      books = BookRepository.new
      list_of_books = books.all
      expect(list_of_books.length).to eq 2
      expect(list_of_books[0].id).to eq("1")
      expect(list_of_books[0].title).to eq("Harry Potter and The Philosophers Stone")
    end
  end
end
