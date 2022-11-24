{{UserAccount}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table


Table: user_accounts

Columns:
username, email_address  



2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here. 


-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY CASCADE;   #to remove posts not matched to users 

INSERT INTO user_account (user_name,email_address) VALUES ('a1001', 'a1@aol.com');
INSERT INTO user_account (user_name,email_address) VALUES ('b2002', 'b2@gmail.com');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < seeds_user_accounts.sql




3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.



# UserAccount class
# (in lib/useraccount.rb)
class UserAccount
end

# UserAccounts class
# (in lib/useraccounts_repository.rb)
class UserAccountRepository
end


4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


class UserAccount
  attr_accessor :id, :username, :email_address
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

class UserAccountRepository


  def all
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts;
    # Returns an array of User Account objects.
  end


  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts WHERE id = $1;
    # Returns a single User Account object.
   end

  def create(user_account)
    #Executes the SQL query: 
    #INSERT INTO user_accounts (username, email_address) VALUES ($1, $2);
    #Insert a single User Account object
    #returns nothing
  end

  def update(user_account)
   #Executes the SQL query:
   #UPDATE user_accounts SET username = $1, email_address = $2,  WHERE id = $3
   #returns nothing 
  end

   def delete(id)
   #Executes the SQL query:
   #DELETE FROM user_accounts WHERE id = $1;
   #returns nothing 
   end

end


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all user_accounts 

repo = UserAccountRepository.new

user_account = repo.all

expect(post.length) # =>  2
  
expect(post.first.username # =>  a1001
expect(post.first.email_address) # =>  a1@aol.com



# 2
# Gets a single user_account 

repo = UserAccountRepository.new

user_account = repo.find(1)

expect(post.first.username # =>  a1001
expect(post.first.email_address) # =>  a1@aol.com

# 3
# Gets another single user_account 

repo = UserAccountRepository.new

user_account = repo.find(1)

expect(post.first.username # =>  b2002
expect(post.first.email_address) # =>  b2@gmail.com


# 4 
# creates a new user_account 

repo = UserAccountRepository.new

new_account = Post.new

new_account.username =  brandnewuser
new_account.email_address =  brandnew@aol.com


repo.create(user_account) 


   all_users = repo.all

   expect(all_users).to include(
    have_attributes(
      title: new_account.username, 
      email_address: 'brandnew@aol.com,
    )
   )
  end
end





# updates a user_account 

repo = UserAccountRepository.new 
user_account = repo.find(1)

user_account.username =  'updatedusername'
user_account.email_address = 'update@gmail.com'


repo.update(user_account)

expect(updated_user.username).to eq ('updatedusername')
expect(updated_user.emaiL_address).to eq('update@gmail.com')



# 4
# delete a user_account 

repo = UserAccountRepository.new 
repo.delete(1)
repo.delete(2)

all_users = repo.all
expect(all_users.length).to eq 0



7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/posts_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_account.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end



8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

