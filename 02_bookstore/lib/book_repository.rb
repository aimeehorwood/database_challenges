require_relative "book"

class BookRepository
  def all
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books;

    sql = "SELECT id,title,author_name FROM books;"
    result_set = DatabaseConnection.exec_params(sql, [])

    books_list = []

    result_set.each do |book|
      book_one = Book.new
      book_one.id = book["id"]
      book_one.title = book["title"]
      book_one.author_name = book["author_name"]

      books_list << book_one
    end

    return books_list
  end
end
