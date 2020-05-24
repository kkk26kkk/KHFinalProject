drop table member;
create table member(
	ID					VARCHAR2(100)	NOT NULL,	-- 아이디
	PW					VARCHAR2(20)	NOT NULL,	-- 비밀번호
	NAME				VARCHAR2(50)	NOT NULL,	-- 이름
	PHONE				VARCHAR2(20)	NOT NULL,	-- 휴대폰번호
	BIRTH				VARCHAR2(20)	NOT NULL,	-- 생년월일
	GENDER				VARCHAR2(10)	NOT NULL,	-- 성별
	SIDO				VARCHAR2(50),				-- 시도
	SIGUNGU				VARCHAR2(50),				-- 시군구
	M_HOBBY				VARCHAR2(500),				-- 취미(매칭)
	M_AGE				VARCHAR2(20),				-- 연령(매칭)
	M_FLAG				VARCHAR2(5),				-- 매칭허용여부
	M_PR				VARCHAR2(4000),				-- 자기소개(매칭)
	AUTH_STATUS 		NUMBER,						-- 로그인 가능 상태 (1:가능 2:불가능)
	BG_IMG_FILE 		VARCHAR2(300),
	BG_IMG_ORIGINAL 	VARCHAR2(300),
	PROF_IMG_FILE 		VARCHAR2(300),
	PROF_IMG_ORIGINAL 	VARCHAR2(300),
	ON_OFF NUMBER,									-- 현재 로그인 상태(1:로그인 2:로그아웃)
	PRIMARY KEY(ID)
);

create sequence join_member_seq

alter table member
add AUTH_STATUS number;

alter table member
add prof_img_file varchar2(300)
alter table member
add prof_img_original varchar2(300)

alter table member
drop column bg_img

alter table member
modify m_gender varchar2(10)

select * from member;
delete from member where id = 'staryoman@gmail.com';

select * from member
where id = 'staryoman@gmail.com'
and auth_status = 1

update member
set auth_status = 1
where id = 'staryoman@gmail.com';

select * from sido

select * from member
where name = null
or phone = '01087362611'
and auth_status = 1

-- 매칭
select *
from member
where auth_status = 1
and sigungu = '고양시 일산서구' and
-- and 1 = 0
m_hobby like '%스포츠%' or
m_hobby like '%여행%' or
m_hobby like '%뷰티%'or
m_hobby like '%게임%'
-- and m_gender = '여자'
and m_age = '20~30대'
and m_flag = 1

select *
from member
where auth_status = 1 
and sigungu = '고양시 일산서구'
and m_age = '30~40대' 
and m_flag = 1
and
(m_hobby like '%영화%' or m_hobby like '%요리%' or m_hobby like '%여행%')

select *
from member
where auth_status = 1 
--and sido = '경기도'
--and sigungu = '고양시 일산서구'
--and m_age = '30~40대' 
and m_flag = 1
and
(m_hobby like '%영화%' or m_hobby like '%요리%' or m_hobby like '%여행%')

update member
set m_flag = '1'
where id = 'khr4863@naver.com'

alter table member
modify m_flag varchar2(5)

alter table member
rename column m_no to my_no

select * from member
where (name = '김혜림'
or phone = '김혜림')
and auth_status = 1
and id != 'khr4863@naver.com'

update member
set prof_img_file = '/human.jpg',
bg_img_file = '/blackbg.jpg'
where id != 'khr4863@naver.com'

alter table member
drop column m_gender

select * from member
where auth_status = 1
and m_flag = 1
and sido = '경기도'
and m_hobby like '%영화%'

select a.*, b.id2, c.accept_id
from member a
left outer join friendlist b
on b.id1 = 'kkk26kkk@naver.com' and a.id = b.id2
left outer join friendrequest c
on c.request_id = 'kkk26kkk@naver.com' and a.id = c.accept_id
where (name = '01012341234' or phone = '01012341234')
and auth_status = 1

select a.*, b.id2, c.accept_id
from member a
left outer join friendlist b
on b.id1 = 'kkk26kkk@naver.com' and a.id = b.id2
left outer join friendrequest c
on c.request_id = 'kkk26kkk@naver.com' and a.id = c.accept_id
where auth_status = 1
and m_flag = 1
and m_hobby like '%여행%'

select * from friendlist
where id1 = 'kkk26kkk@naver.com'

select * from friendrequest
where request_id = 'kkk26kkk@naver.com'

select id, m_hobby from member
