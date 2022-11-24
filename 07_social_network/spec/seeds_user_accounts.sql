
TRUNCATE TABLE user_account RESTART IDENTITY CASCADE;

INSERT INTO user_account (user_name,email_address) VALUES ('a1001', 'a1@aol.com');
INSERT INTO user_account (user_name,email_address) VALUES ('b2002', 'b2@gmail.com');
