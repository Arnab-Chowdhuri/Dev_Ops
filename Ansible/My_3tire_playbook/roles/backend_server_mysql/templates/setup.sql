create user 'arnab' identified by 'arnab123';
create database mysql_db;
GRANT ALL privileges ON mysql_db.* TO 'arnab'@'%';
FLUSH PRIVILEGES;
