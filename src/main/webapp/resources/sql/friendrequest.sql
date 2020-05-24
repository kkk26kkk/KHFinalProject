drop table friendrequest;
create table friendrequest(
request_id varchar2(100),	-- 요청자 아이디
accept_id varchar2(100),	-- 수락자 아이디
m_friend number				-- 매칭 친구 구분자 (1: 일반  2: 매칭)
);

-- 제약 조건
alter table friendrequest
add foreign key(request_id) references member(id);

-- 제약 조건
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
