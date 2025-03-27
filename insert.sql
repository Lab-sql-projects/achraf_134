-- Insert data into Users table
INSERT INTO Users (username, email) VALUES
('john_doe', 'john.doe@example.com'),
('jane_smith', 'jane.smith@example.com'),
('bob_jones', 'bob.jones@example.com');

-- Insert data into Comments table
INSERT INTO Comments (user_id, post_id, comment_text) VALUES
(1, 1, 'This is a great post!'),
(2, 1, 'I totally agree with this post.'),
(3, 1, 'I have some doubts about this post.');