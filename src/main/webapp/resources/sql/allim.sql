drop table allim;
create table allim(
a_flag number not null,		-- �˸� ������ (1:ģ�� 2:��Īģ�� 3:���ƿ� 4:���)
a_no number not null,		-- �˸� ����
read_check number,			-- �о����� ���о����� üũ (1:������ 2:����)
name varchar2(50),			-- �˸� ������ ����� �̸�
id varchar2(100),			-- �˸� ������ ����� ���̵�
accept_id varchar2(100),	-- �˸� �޴� ����� ���̵�
board_no number,			-- �� ��ȣ + ���� ���� �߰�(fk)
reply_no number,			-- ��� ��ȣ
reply_id varchar2(100),		-- ��� ��� ���̵�
reg_date date				-- �˸� ��� �Ͻ�
);

-- ���� ����
alter table allim
add foreign key(id) references member(id);

-- ���� ����
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

-- ���� ��ũ��
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

