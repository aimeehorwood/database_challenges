{blog} Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```
Nouns:  

post, title, content,  
comment, content, author_name, post_id 



2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.


| Record      | Properties                 |
| ----------- | -------------------------  |
| posts       | title, content             |
| comments    | content,author_name,post_id|



Name of the first table (always plural): `posts`

Column names: `title`, `content`

Name of the second table (always plural): 'comments'

Column names: `content`, `author_name`, `post_id`



3. Decide the column types.
````
Table: posts
id: SERIAL
title: text
content: text


Table: comments
id: SERIAL
content: text
author_name: text
post_id: int

```

4. Decide on The Tables Relationship

````
Can one post have many comments? (Yes)
Can one comment have many posts? (No)

You'll then be able to say that:

A post has many comments,
A comment belongs to a post

Therefore, the foreign key is on the comments table. 

````


4. Write the SQL.

```
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  contents text
);


CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text,
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);

```
5. Create the tables.
psql -h 127.0.0.1 blog < blog_table.sql
