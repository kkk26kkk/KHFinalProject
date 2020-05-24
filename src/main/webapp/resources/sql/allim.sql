drop table allim;
create table allim(
a_flag number not null,		-- 알림 구분자 (1:친구 2:매칭친구 3:좋아요 4:댓글)
a_no number not null,		-- 알림 순번
read_check number,			-- 읽었는지 안읽었는지 체크 (1:안읽음 2:읽음)
name varchar2(50),			-- 알림 보내는 멤버의 이름
id varchar2(100),			-- 알림 보내는 멤버의 아이디
accept_id varchar2(100),	-- 알림 받는 멤버의 아이디
board_no number,			-- 글 번호 + 제약 조건 추가(fk)
reply_no number,			-- 댓글 번호
reply_id varchar2(100),		-- 댓글 등록 아이디
reg_date date				-- 알림 등록 일시
);

-- 제약 조건
alter table allim
add foreign key(id) references member(id);

-- 제약 조건
alter table allim
add foreign key(accept_id) references member(id);

select * from member;
select * from allim;

select * from (
select b.name, b.prof_img_file prof_img_file, a.*
from allim a
inner join member b
on a.id = b.id 
where a.accept_id = 'kkk26kkk@naver.com'
order by a.reg_date desc
)
where rnum >= 1 and rnum <= 5;

select count(*)
from allim
where read_check = 1 and accept_id = 'kkk26kkk@naver.com';

select *
from allim
where accept_id = 'kkk26kkk@naver.com';

create sequence allim_no_seq

-- 무한 스크롤
select * from (
select rownum rnum, b2.* from (
select b.name, b.prof_img_file, a.a_flag, a.a_no, a.read_check,
a.id, a.accept_id, a.board_no, a.reply_no, a.reg_date 
from allim a
inner join member b
on a.id = b.id 
where a.accept_id = 'kkk26kkk@naver.com'
order by a.reg_date desc
) b2
order by rnum
)
where rnum >= 10 and rnum <= 18

