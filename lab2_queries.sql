-- Lab 2 SQL Queries
-- File: lab2_queries.sql
-- Author: [Your Name]
-- Date: [Current Date]

/*
=== TEST DATA SETUP ===
Creates sample data to demonstrate the queries
*/

-- Add test users (including inactive ones)
INSERT INTO users (username, email, password) VALUES 
('inactive_user', 'inactive@example.com', 'testpass123'),
('test_user', 'test@example.com', 'testpass456');

-- Add test post from inactive user
INSERT INTO posts (user_id, content) VALUES 
((SELECT user_id FROM users WHERE username = 'inactive_user'), 
'Test post from inactive user');

-- Add test comment
INSERT INTO comments (user_id, post_id, comment_text) VALUES 
((SELECT user_id FROM users WHERE username = 'test_user'),
1,  -- Post ID 1
'Test comment');

/*
=== REQUIRED QUERIES ===
*/

-- 1. INNER JOIN: Shows all comments with author usernames and post content
SELECT u.username, p.content, c.comment_text
FROM comments c
INNER JOIN users u ON c.user_id = u.user_id
INNER JOIN posts p ON c.post_id = p.post_id;

-- 2. LEFT JOIN: Shows all users, even those who never commented
SELECT u.username, c.comment_text
FROM users u
LEFT JOIN comments c ON u.user_id = c.user_id;

-- 3. UPDATE: Appends " - edited" to post content
UPDATE posts
SET content = CONCAT(content, ' - edited')
WHERE post_id = 1;

-- 4. DELETE: Removes old likes (before 2023)
DELETE FROM likes
WHERE liked_at < '2023-01-01';

-- 5. AGGREGATION: Counts comments per post (only shows posts with comments)
SELECT post_id, COUNT(*) AS comment_count
FROM comments
GROUP BY post_id
HAVING COUNT(*) >= 1;

-- 6. SUBQUERY: Finds users who never liked any post
SELECT username
FROM users
WHERE user_id NOT IN (SELECT user_id FROM likes);

/*
=== VERIFICATION QUERIES ===
Optional: Include these to show the changes
*/

-- Show all posts after editing
SELECT * FROM posts;

-- Show users who never liked posts (matches subquery result)
SELECT u.username 
FROM users u
LEFT JOIN likes l ON u.user_id = l.user_id
WHERE l.like_id IS NULL;