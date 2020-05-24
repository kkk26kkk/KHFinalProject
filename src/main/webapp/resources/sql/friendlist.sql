drop table friendlist;
create table friendlist(
id1 		varchar2(100),
id2 		varchar2(100),
m_friend 	number
);

-- ���� ����
alter table friendlist
add foreign key(id1) references member(id);

-- ���� ����
alter table friendlist
add foreign key(id2) references member(id);

select * from FRIENDLIST
where id1 = 'kkk26kkk@naver.com'

delete from friendlist

insert all
into FRIENDLIST values ('kkk26kkk@naver.com', 'abcd@example.com', 1)
into FRIENDLIST values ('abcd@example.com', 'kkk26kkk@naver.com', 1)
SELECT * FROM dual

/** ģ�� ���� �� ��û ��Ͽ� �ִ� �� ���� **/
create or replace trigger friendlist_trig
	after insert on friendlist
	for each row
begin
	delete from friendrequest
	where (request_id = :new.id1 and accept_id = :new.id2)
	or (request_id = :new.id2 and accept_id = :new.id1);
end;

select a.*
from member a
inner join friendlist b
on a.id = b.id2
where b.id1 = 'kkk26kkk@naver.com'