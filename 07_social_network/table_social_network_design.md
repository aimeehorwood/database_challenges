{social_network)Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns:

user account, email address , username 
post, title, content , views, user_account_id 


Table: user_accounts
id: SERIAL
username: text
email_address: text

Table: posts
id: SERIAL
title: text
content: text
views: int
user_account_id: int



2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.


Name of the first table (always plural): user_accounts

Column names: username , email_address

Name of the second table (always plural): posts

Column names: title,content,views,user_account_id 


| Record        | Properties                            |
| -----------   | -------------------------------       |
| user_accounts | username, email_address               |
| posts         | title, content, views,user_account_id |




3. Decide the column types.

```
Table: user_accounts 
id: SERIAL
username: text
email_address: text

Table: posts
id: SERIAL
title: text 
content: text 
views:  int
user_account_id: int 

```


4. Decide on The Tables Relationship


Can one user_account have many posts? (Yes)
Can one post have many user_accounts? (No)

Therefore,

--> A user account can HAVE MANY posts 
--> A post BELONGS to only one user account 

Therefore, the foreign key is on the posts table (user_account_id)




4. Write the SQL.


-- Create the table without the foreign key first.

CREATE TABLE user_account (
  id SERIAL PRIMARY KEY,
  user_name text,
  email_address text
);


-- Then the table with the foreign key first.



CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
-- The foreign key name is always {other_table_singular}_id
  user_account_id int,
  constraint fk_user_account foreign key(user_account_id)
    references user_account(id)
    on delete cascade
);


5. Create the tables.
psql -h 127.0.0.1 social_network < social_network_table.sql
