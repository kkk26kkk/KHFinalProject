drop table reply;

create table reply(
	id 			varchar2(100),
	board_no 	number,
	reply_no 	number,				
	reply_id 	varchar2(100)	not null,				
	name 		varchar2(50)	not null,
	content 	varchar2(4000)	not null,
	re_ref 		number,
	re_lev 		number,
	re_seq		number,
	reg_date 	date,
	
	foreign key(id, board_no) references board(id, board_no) on delete cascade
	
);

create sequence reply_no_seq;

select * from reply;

delete from REPLY;


insert into reply values('admin@naver.com', 0,1,2,'2번아이디','0번게시글 답글',0,0,0,sysdate);
insert into reply values('admin@naver.com', 1,1,1,'1번아이디','1번게시글 답글',0,0,0,sysdate);


insert into reply values('user1', 9,1,2,'2번이름','9번게시글 답글1',0,0,0,sysdate);
insert into reply values('user1', 9,2,1,'1번이름','9번게시글 답글2',0,0,0,sysdate);
insert into reply values('user1', 9,3,2,'2번이름','9번게시글 답글3',0,0,0,sysdate);
insert into reply values('user1', 9,4,1,'1번이름','9번게시글 답글4',0,0,0,sysdate);
insert into reply values('user1', 9,5,2,'2번이름','9번게시글 답글5',0,0,0,sysdate);
insert into reply values('user1', 9,6,1,'1번이름','9번게시글 답글6',0,0,0,sysdate);
insert into reply values('user1', 9,7,2,'2번이름','9번게시글 답글7',0,0,0,sysdate);
insert into reply values('user1', 9,8,1,'1번이름','9번게시글 답글8',0,0,0,sysdate);

insert into reply values('user1', 10,1,2,'2번이름','10번게시글 답글1',0,0,0,sysdate);
insert into reply values('user1', 10,2,1,'1번이름','10번게시글 답글2',0,0,0,sysdate);
insert into reply values('user1', 10,3,2,'2번이름','10번게시글 답글3',0,0,0,sysdate);
insert into reply values('user1', 10,4,1,'1번이름','10번게시글 답글4',0,0,0,sysdate);
insert into reply values('user1', 10,5,2,'2번이름','10번게시글 답글5',0,0,0,sysdate);
insert into reply values('user1', 10,6,1,'1번이름','10번게시글 답글6',0,0,0,sysdate);
insert into reply values('user1', 10,7,2,'2번이름','10번게시글 답글7',0,0,0,sysdate);
insert into reply values('user1', 10,8,1,'1번이름','10번게시글 답글8',0,0,0,sysdate);


insert into reply values('user1', 1,1,1,'1번사람','ㅋㅋㅋ',0,0,0,sysdate);
insert into reply values('user1', 2,2,2,'2번사람','2번뽑아',0,0,0,sysdate);
insert into reply values('user1', 3,3,3,'3번사람','3초라도 안보이면',0,0,0,sysdate);
insert into reply values('user2', 1,4,4,'4번사람','죽을거같다',0,0,0,sysdate);
insert into reply values('user2', 2,5,2,'2번사람','2번뽑아',0,0,0,sysdate);
insert into reply values('user3', 2,6,1,'1번사람','ㅋㅋㅋ',0,0,0,sysdate);
insert into reply values('user3', 1,7,2,'2번사람','2번뽑아',0,0,0,sysdate);



select * from reply where id = 'user1' and board_no = 9 order by reply_no


select * from reply where re_ref asc

select * 
			from 
				(select rownum rnum, id, board_no, reply_no, 
						my_no, name, content, re_ref, re_lev, re_seq, reg_date 
				from (select * 
						from (select distinct *  from reply where re_seq = 0)
						where id = 'admin@naver.com' and  board_no = 14 
						order by re_ref asc , re_lev asc, re_seq desc)	 
				)
	where rnum >= (1*5-4) and rnum <= (1*5) 

select count(*) from reply where id = 'admin@naver.com' and board_no = 5

select * from 
(select rownum rnum, id, board_no, reply_no, my_no, name, content, re_ref, re_lev, re_seq, reg_date 
	from (select * 
			from (select distinct *  from reply where re_seq > 0)
			where id = 'admin@naver.com' and  board_no = 14 and re_ref = 0
			order by re_ref asc , re_lev asc, re_seq desc)	 
				)
where rnum >= (1*5-4) and rnum <= (1*5) 

select * from reply where id = 'admin@naver.com' and board_no = 14 and reply_no = 14
