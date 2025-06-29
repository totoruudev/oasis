create database oasis;
use oasis;
show tables;

select * from user;

UPDATE user
SET role = 'ADMIN'
WHERE id = 1;
