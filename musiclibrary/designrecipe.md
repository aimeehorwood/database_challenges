{{TABLE NAME}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: albums

Columns:
id | title | release_year

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_music_library.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title,release_year,artist_id) VALUES ('Louis Armstrong Hits', '1970','1');
INSERT INTO albums (title,release_year,artist_id) VALUES ('Buzzard Buzzard Buzzard', '2022', '2');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 music_library_test < spec/seeds_albums.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)
class Album
attr_accessor :title, :id, :release_year
end

# Repository class
class AlbumRepository

def all_albums
#executes the SQL suery

albums = []
sql = 'SELECT id, title FROM albums;'
album_set = DatabaseConnection.exec_params(sql,[])
album_set.each do |album|
  albums.push("#{album[:id]}: #{album[:title]}")
end
albums
#returns an array of Album objects
end

#select a single album record
#given its id in argument (a number)

def find(id)
#executes the SQL
#SELECT id,title, release_year, artist_id FROM albums WHERE id =$1;

#returns a single object 


def create(album)

#INSERTS into album (title,release_year,artist id) VALUES ($1, $2, $3);
#returns nothing 
end 

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

class Album
attr_accessor :title, :id, :release_year
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  #execute the SQL query:
  INSERT TO albums (title,release_year,artist_id)
  VALUES ('Bob Marley Greatest Hits','1990','6')
  # end

  # def update(student)
  UPDATE albums SET 'Bob Marley Greatest Hits' = 'Best of Bob Marley' WHERE artist_id = '6'; 
  # end

  # def delete(student)
  DELETE FROM albums WHERE album.title = album;
  # end


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all albums

albums = AlbumsRepository.new

list_of_album = albums.all

list_of_albums.length # =>  2

list_of_albums[0].id # =>  1
list_of_albums[0].title # =>  'Louis Armstrong Hits'
list_of_albums[0].release_year # =>  1970

list_of_albums[1].id # =>  2
list_of_albums[1].title # =>  'Buzzard Buzzard Buzzard'
list_of_albums[1].release_year # =>  2022


# 2
# Get all albums when there are no albums in the databse

albums = AlbumRepository.new
list_of_albums = albums.all # =>[]

#3
# Get a single album ('Louis Armstrong Hits')

albums = AlbumRepository.new
list_of_albums = albums.find(1)

list_of_albums.title # => 'Louis Armstrong Hits'
list_of_albums.id # => '1'
list_of_albums.release_year # => '1970'



#4 
# Get a single album ('Buzzard Buzzard Buzzard')

albums = AlbumRepository.new
list_of_albums = albums.find(2)

list_of_albums.title # => 'Buzzard Buzzard Buzzard'
list_of_albums.id # => '2'
list_of_albums.release_year # => '2022'



#5
# Create a single album 

albums = AlbumRepository.new
album.title = '30'
album.id = '3' 
album.release_year = '2021'

repo.create(album)

all albums = repo.all

# the all_albums array should contain the new Album object 



# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end


8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.