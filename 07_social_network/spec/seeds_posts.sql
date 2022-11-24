TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content,views,user_account_id) VALUES ('title1', 'content1','100','1');
INSERT INTO posts (title, content,views,user_account_id) VALUES ('title2', 'content2','200','2');