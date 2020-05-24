drop table member;
create table member(
	ID					VARCHAR2(100)	NOT NULL,	-- ���̵�
	PW					VARCHAR2(20)	NOT NULL,	-- ��й�ȣ
	NAME				VARCHAR2(50)	NOT NULL,	-- �̸�
	PHONE				VARCHAR2(20)	NOT NULL,	-- �޴�����ȣ
	BIRTH				VARCHAR2(20)	NOT NULL,	-- �������
	GENDER				VARCHAR2(10)	NOT NULL,	-- ����
	SIDO				VARCHAR2(50),				-- �õ�
	SIGUNGU				VARCHAR2(50),				-- �ñ���
	M_HOBBY				VARCHAR2(500),				-- ���(��Ī)
	M_AGE				VARCHAR2(20),				-- ����(��Ī)
	M_FLAG				VARCHAR2(5),				-- ��Ī��뿩��
	M_PR				VARCHAR2(4000),				-- �ڱ�Ұ�(��Ī)
	AUTH_STATUS 		NUMBER,						-- �α��� ���� ���� (1:���� 2:�Ұ���)
	BG_IMG_FILE 		VARCHAR2(300),
	BG_IMG_ORIGINAL 	VARCHAR2(300),
	PROF_IMG_FILE 		VARCHAR2(300),
	PROF_IMG_ORIGINAL 	VARCHAR2(300),
	ON_OFF NUMBER,									-- ���� �α��� ����(1:�α��� 2:�α׾ƿ�)
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

-- ��Ī
select *
from member
where auth_status = 1
and sigungu = '���� �ϻ꼭��' and
-- and 1 = 0
m_hobby like '%������%' or
m_hobby like '%����%' or
m_hobby like '%��Ƽ%'or
m_hobby like '%����%'
-- and m_gender = '����'
and m_age = '20~30��'
and m_flag = 1

select *
from member
where auth_status = 1 
and sigungu = '���� �ϻ꼭��'
and m_age = '30~40��' 
and m_flag = 1
and
(m_hobby like '%��ȭ%' or m_hobby like '%�丮%' or m_hobby like '%����%')

select *
from member
where auth_status = 1 
--and sido = '��⵵'
--and sigungu = '���� �ϻ꼭��'
--and m_age = '30~40��' 
and m_flag = 1
and
(m_hobby like '%��ȭ%' or m_hobby like '%�丮%' or m_hobby like '%����%')

update member
set m_flag = '1'
where id = 'khr4863@naver.com'

alter table member
modify m_flag varchar2(5)

alter table member
rename column m_no to my_no

select * from member
where (name = '������'
or phone = '������')
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
and sido = '��⵵'
and m_hobby like '%��ȭ%'

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
and m_hobby like '%����%'

select * from friendlist
where id1 = 'kkk26kkk@naver.com'

select * from friendrequest
where request_id = 'kkk26kkk@naver.com'

select id, m_hobby from member
