-- Lab 4 Queries
-- File: lab4_queries.sql
--achraf laksiri 134 
-- Step 1: Create a VIEW to hide sensitive columns from the users table
CREATE VIEW PublicUsers AS
    SELECT user_id, username
    FROM users;

-- Step 2: Add Integrity Constraints

-- Add a UNIQUE constraint on the email column in the users table
ALTER TABLE users
    ADD CONSTRAINT UNIQUE (email);

-- Add a FOREIGN KEY constraint to link the comments table with the users table
ALTER TABLE comments
    ADD CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Step 3: Create an INDEX on the user_id column in the comments table
CREATE INDEX idx_user_id ON comments(user_id);

-- Step 4: Create and test a TRANSACTION

-- Start a transaction
START TRANSACTION;

-- Insert a new user into the users table
INSERT INTO users (username, email, password, created_at)
    VALUES ('new_user', 'newuser@email.com', 'newpassword', NOW());

-- Update a post content
UPDATE posts
    SET content = 'Updated content for post 1'
    WHERE post_id = 1;

-- Commit the transaction
COMMIT;

-- Step 5: Write a Complex Query with JOIN, Subquery, and WHERE condition

-- Complex query to fetch posts with comments where the post has more than one comment
SELECT
    p.post_id,
    p.content AS post_content,
    u.username AS post_username,
    c.comment_text,
    c.commented_at,
    cu.username AS comment_username
FROM posts p
JOIN comments c ON p.post_id = c.post_id
JOIN users u ON p.user_id = u.user_id
JOIN users cu ON c.user_id = cu.user_id
WHERE p.post_id IN (SELECT post_id FROM comments GROUP BY post_id HAVING COUNT(*) > 1)
ORDER BY p.post_id, c.commented_at;

-- Step 6: Create a New Role and Grant SELECT Privileges

-- Create a new user
CREATE USER 'new_role_user'@'localhost' IDENTIFIED BY 'password123';

-- Grant SELECT privilege on the PublicUsers view to the new user
GRANT SELECT ON PublicUsers TO 'new_role_user'@'localhost';

-- Create a new role for viewing data
CREATE ROLE 'view_only_role';

-- Grant SELECT privilege on PublicUsers to the view_only_role
GRANT SELECT ON PublicUsers TO 'view_only_role';

-- Assign the view_only_role to the new user
GRANT 'view_only_role' TO 'new_role_user'@'localhost';

-- End of Lab 4 Queries
