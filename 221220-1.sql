-- �а� ���̺�
create table department(
    code varchar2(4) primary key,
    name varchar2(15)
);

-- �л� ���̺�
create table student(
    no number(3) PRIMARY key,
    name varchar2(12),
    code varchar2(4),
    foreign key(code) references department(code) 
);

drop table student;
-- �а� ������ �Է�
insert into department values('1001','��ǻ���а�');
insert into department values('2001','ü���а�');

select * from department;
commit;

-- �л� ������ �Է�
INSERT into student values(501,'������','1001');
INSERT into student values(401,'�迬��','2001');
INSERT into student values(402,'��̶�','2001');
INSERT into student values(502,'�߽ż�','1001');
select * from student;
commit;

insert into department values('3001','ö�а�');
INSERT into student values(601,'ȫ�浿','3001');
select * from department;
select * from student;
rollback;
commit;

delete from student
    where no = 601;
delete from department
    where code = '3001';
commit;    

drop table newbook4;
create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- ���� 3-37, �Ӽ� �߰�
alter table newbook add isbn varchar2(13);
-- ���̺� ����
desc newbook;
-- ���� 3-38, �Ӽ� Ÿ�� ����
alter table newbook modify isbn number;
-- ���� 3-39, �Ӽ� ����
alter table newbook drop column isbn;
-- ���� 3-40, not null �������� �߰�
alter table newbook modify bookid number not null;
-- ���� 3-41
alter table newbook add primary key(bookid);

-- �������� ������ ���� �̸�

select t2.name "�̸�",t3.bookname"������" , t3.price"����", t1.saleprice"�ǸŴܰ�"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '������';
    
select * from customer;    
select * from book;
select * from orders;