-- Query to fetch comments for post_id = 1 with the username of the user who commented
SELECT Comments.comment_id, Users.username, Comments.comment_text, Comments.commented_at
FROM Comments
JOIN Users ON Comments.user_id = Users.user_id
WHERE Comments.post_id = 1
ORDER BY Comments.commented_at DESC;

-- You can add more queries below
-- Example: Fetch all users
SELECT * FROM Users;