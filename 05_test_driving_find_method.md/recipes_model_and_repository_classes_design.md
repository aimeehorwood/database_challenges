{{Recipes}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  cooking_time int,
  rating int,
);

Columns:
id | name | cooking_time | rating



2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.


-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time,rating) VALUES ('Lasagne', '75', '5');
INSERT INTO recipes (name, cooking_time,rating) VALUES ('Vodka Pasta','30','3');



id | name | cooking_time | rating


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 recipe_directory_test < seeds_{table_name}.sql



3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: recipes

# Model recipe
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end


4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Recipe
  attr_accessor :id, :name, :cooking_time, :rating
end


5. Define the Repository Class interface


class RecipeRepository

  # Selecting all recipes

  def all
    # Executes the SQL query:
    # SELECT id, name, cooking_time,rating FROM recipes;
    # Returns an array of Recipe objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cooking_time,rating FROM recipes WHERE id = $1;
    # Returns a single Recipe object.
  end
end



6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  2
recipes.first.name # =>  'Lasagne'
recipes.first.cooking_time # =>  '75'
recipes.first.rating # => '5'



# 2
# Get a single recipe ('Lasagne')

repo = RecipeRepository.new

recipes = repo.find(1)
recipes.name # =>  'Lasagne'
recipes.cooking_time # =>  '75'
recipes.rating # => '5'


# 3
# Get another single recipe ('Vodka Pasta')

repo = RecipeRepository.new

recipes = repo.find(2)
recipes.name # =>  'Vodka Pasta'
recipes.cooking_time # =>  '30'
recipes.rating # => '3'



7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/recipes_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  # (your tests will go here).
end



8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.