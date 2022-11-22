# file: app.rb

require_relative "lib/database_connection"
require_relative "lib/book_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect("book_store")

# Perform a SQL query on the database and get the result set.
sql = "SELECT id, title,author_name FROM books;"
result = DatabaseConnection.exec_params(sql, [])

books_one = BookRepository.new

books_one.all.each do |book|
  puts "#{book.id} - #{book.title} - #{book.author_name}"
end
