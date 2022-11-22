{BookStore}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.


Table: books

Columns:
id | title | author_name

{"id"=>"1", "title"=>"Nineteen Eighty-Four"}
{"id"=>"2", "title"=>"Mrs Dalloway"}
{"id"=>"3", "title"=>"Emma"}
{"id"=>"4", "title"=>"Dracula"}
{"id"=>"5", "title"=>"The Age of Innocence"}


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{book_store_seeds}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE books RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO books (title, author_name) VALUES ('Harry Potter and The Philosophers Stone', 'JK Rowling');
INSERT INTO books (title, author_name) VALUES ('Little Women', 'Louisa May Alcott');



Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: students

# Model class
# (in lib/book.rb)
class Book
attr_accessor :id, :title, :author_name
end


# Repository class
# (in lib/book_repository.rb)
class BookRepository
end





4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# Table name: book

# Model class
# (in lib/book.rb)

class Book
attr_accessor :id, :title, :author_name
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: books

# Repository class
# (in lib/book_repository.rb)

class BookRepository
end

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, author_name FROM books;

    sql = "SELECT id,title,author_name FROM books;"
    result_set = DatabaseConnection.exec_params(sql,[])

    books_list = []

    result_set.each do |book|
      book_one = Book.new
     # book_one.id = book["id"]
     # book_one.title = book["title"]
     # book_one.author_name = book["author_name"]

      books_list << book_one
    end

    return books_list
  end
end



6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# return all books

context "all method" do 
it "returns a list of all the books" do 
books = BookRepository.new 
list_of_books = books.all
expect(list_of_books.length).to eq 2


---------
it "returns all books" do 
books = BookRepository.new
list_of_books = books.all
expect(list_of_books).to eq ["1 Harry Potter and The Philosophers Stone", "2 Little Women Louisa May Alcott" ]


------ 

books[0].id # =>  1
books[0].title # =>  'Harry Potter and The Philosophers Stone'
books[0].author_name # =>  'JK Rowling'

students[1].id # =>  2
students[1].name # =>  'Little Women'
students[1].cohort_name # =>  'Louisa May Alcott'


7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/book_repository_spec.rb

def reset_books_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

