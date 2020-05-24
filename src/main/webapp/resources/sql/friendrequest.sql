drop table friendrequest;
create table friendrequest(
request_id varchar2(100),	-- ��û�� ���̵�
accept_id varchar2(100),	-- ������ ���̵�
m_friend number				-- ��Ī ģ�� ������ (1: �Ϲ�  2: ��Ī)
);

-- ���� ����
alter table friendrequest
add foreign key(request_id) references member(id);

-- ���� ����
alter table friendrequest
add foreign key(accept_id) references member(id);

select * from friendrequest
where accept_id = 'kkk26kkk@naver.com'

select a.*
from member a
inner join friendrequest b
on a.id = b.request_id
where b.accept_id = 'kkk26kkk@naver.com'

delete from FRIENDREQUEST
where (request_id = 'kkk26kkk@naver.com' and accept_id = 'abcd@example.com')
or (request_id = 'abcd@example.com' and accept_id = 'kkk26kkk@naver.com')
