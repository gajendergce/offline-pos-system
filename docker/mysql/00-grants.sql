-- Ensure the app user can connect from any Docker bridge IP.
-- This runs before sampledb.sql (alphabetical order).
-- MySQL 5.7: IDENTIFIED BY recreates/updates the user if it already exists.
CREATE USER IF NOT EXISTS 'app'@'%' IDENTIFIED BY 'app123';
GRANT ALL PRIVILEGES ON `agrtl_offline`.* TO 'app'@'%' IDENTIFIED BY 'app123';
FLUSH PRIVILEGES;
