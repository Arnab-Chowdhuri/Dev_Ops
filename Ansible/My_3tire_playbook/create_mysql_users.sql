create user 'chatap' identified by 'some passw';
grant all privileges on `chatap`.* to 'chatapp'@'%';
flush privileges;
