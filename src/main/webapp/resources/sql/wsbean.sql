DROP TABLE 	wsbean
CREATE TABLE wsbean(
	s_id varchar2(100),
	r_id varchar2(100),
	m varchar2(4000),
	inputdate date
)

SELECT * FROM wsbean;

select * from (
select rownum rnum, b.* from (
select * from wsbean 
where r_id = 'kkk26kkk@naver.com' or s_id = 'kkk26kkk@naver.com'
order by inputdate desc) b )
where rnum = 1

delete from wsbean;