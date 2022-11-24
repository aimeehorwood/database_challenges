{{Post}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table


Table: posts

Columns:
id | title | content | views | user_account_id 



2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 


-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content,views,user_account_id) VALUES ('title1', 'content1','100','1');
INSERT INTO posts (title, content,views,user_account_id) VALUES ('title2', 'content2','200','2');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_posts.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.



# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end


4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


class Post
  attr_accessor :id, :title, :content, :views, :user_account_id
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

class PostRepository


  def all
    # Executes the SQL query:
    # SELECT title, content, views, user_account_id FROM posts;
    # Returns an array of Student objects.
  end


  def find(id)
    # Executes the SQL query:
    # SELECT title,content,views,user_account_id FROM posts WHERE id = $1;
    # Returns a single Student object.
   end

  def create(post)
    #Executes the SQL query: 
    #INSERT INTO posts (title,content,views,user_account_id) VALUES ($1, $2, $3, $4);
    #Insert a single Post object
    #returns nothing
  end

  def update(post)
   #Executes the SQL query:
   #UPDATE posts SET title = $1, content = $2, views = $3 , user_account_id = $4 WHERE id = $5 
   #returns nothing 
  end

   def delete(id)
   #Executes the SQL query:
   #DELETE FROM posts WHERE id = $1;
   #returns nothing 
   end

end


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all posts 

repo = StudentRepository.new

post = repo.all

expect(post.length) # =>  2
  
expect(post.first.title # =>  title1
expect(post.first.content) # =>  content2
expect(post.first.views # =>  100




# 2
# Gets a single post 

repo = PostRepository.new

post = repo.find(1)

expect(post.title) # =>  title1
expect(post.content) # =>  content 2
expect(post.views) # =>  100

# 3
# Gets another single post 

repo = PostRepository.new

post = repo.find(2)

expect(post.title) # =>  title2
expect(post.content) # =>  content2
expect(post.views) # =>  200



# 4 
# creates a new post 

repo = PostRepository.new

new_post = Post.new

new_post.title =  brand new 
new_post.content =  brand new content 
new_post.views  =  400
new_post.user_account_id = 4

repo.create(post) 


   all_posts = repo.all

   expect(all_post).to include(
    have_attributes(
      title: new_post.title, 
      content: ' brand new content',
      views: ' 400 ',
      user_account_id: '4',
    )
   )
  end
end


# updates a post 

repo = PostRepository.new 
post = repo.find(1)

post.title =  'update a title'
post.content = 'some updated content'
post.views = 300

repo.update(post)

expect(updated_post.title).to eq ('update a title')
expect(updated_post.content).to eq('some updated content')
expect(updated_post.views).to eq(300)



# 4
# delete a post 

repo = PostRepository.new 
repo.delete(1)
repo.delete(2)

all_posts = repo.all
expect(all_post.length).to eq 0



7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/posts_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end



8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

