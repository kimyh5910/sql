drop table member;
create table member(
    member_id   number(5),          -- ȸ�����̵�
    email       varchar2(30),        -- �̸���
    passwd      varchar2(10),       -- ��й�ȣ
    nickname        varchar2(30)   -- ��Ī    
);

alter table member add constraint member_member_id_pk primary key(member_id);

insert into member values(1,'test@test.com',1234,'�г���1');
insert into member values(2,'test@test.com',1234,'�г���2');
insert into member values(3,'test@test.com',1234,'�г���3');

commit;

select * from member;

-- ������ ��ü ����
create sequence member_member_id_seq
    increment by -2  -- ������ ��ȣ ������, �⺻���� 1
    start with 10    -- ������ ���۹�ȣ, �⺻���� 1
    maxvalue 10    -- ���������� ������ �ִ밪
    minvalue 1    -- ���������� ������ �ּҰ�
    cycle         -- ��������ȣ�� ��ȯ ����� ������ ���� [cycle : nocycle]  
    cache 2;       -- ������ �����ӵ��� �����ϱ� ���� ĳ�̿��� ����

-- ������ ����
drop sequence member_member_id_seq;
    
-- ��������ȣ ����    
select member_member_id_seq.nextval
    from dual;
-- ���� ������ ��ȣ ��ȸ    
select member_member_id_seq.currval
    from dual;
    
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'�г���1');
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'�г���2');
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'�г���3');        

select * from member;