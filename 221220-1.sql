-- 학과 테이블
create table department(
    code varchar2(4) primary key,
    name varchar2(15)
);

-- 학생 테이블
create table student(
    no number(3) PRIMARY key,
    name varchar2(12),
    code varchar2(4),
    foreign key(code) references department(code) 
);

drop table student;
-- 학과 데이터 입력
insert into department values('1001','컴퓨터학과');
insert into department values('2001','체육학과');

select * from department;
commit;

-- 학생 데이터 입력
INSERT into student values(501,'박지성','1001');
INSERT into student values(401,'김연아','2001');
INSERT into student values(402,'장미란','2001');
INSERT into student values(502,'추신수','1001');
select * from student;
commit;

insert into department values('3001','철학과');
INSERT into student values(601,'홍길동','3001');
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

-- 질의 3-37, 속성 추가
alter table newbook add isbn varchar2(13);
-- 테이블 구조
desc newbook;
-- 질의 3-38, 속성 타입 변경
alter table newbook modify isbn number;
-- 질의 3-39, 속성 제거
alter table newbook drop column isbn;
-- 질의 3-40, not null 제약조건 추가
alter table newbook modify bookid number not null;
-- 질의 3-41
alter table newbook add primary key(bookid);

-- 박지성이 구매한 도서 이름

select t2.name "이름",t3.bookname"도서명" , t3.price"정가", t1.saleprice"판매단가"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '박지성';
    
select * from customer;    
select * from book;
select * from orders;