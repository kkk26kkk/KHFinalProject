drop table userauth;
create table userauth(
id varchar2(100),
authKey varchar2(500)
);

-- 제약 조건
alter table userauth
add foreign key(id) references member(id);

select * from userauth;
delete from userauth;

update member
set AUTH_STATUS = 1 
where (select count(*) from userAuth where id = 'staryoman@gmail.com') > 0