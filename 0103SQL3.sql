select name,address,phone
    from customer
    where address like'%대한민국%';
    
create or replace procedure test_1
-- (
    -- 매개변수
--)    

as
    -- 지역변수
    type customer_rec_t is record(
        name    customer.name%type,
        address customer.address%type,
        phone   customer.phone%type
    );
    type customer_table_t is table of customer_rec_t
        index by binary_integer;
    
    l_customer_t    customer_table_t;
begin
    -- 실행문
    select name,address,phone
        bulk collect into l_customer_t
        from customer
    where address like '%대한민국%';
    
    
    for i in 1..l_customer_t.count loop
        dbms_output.put_line(
            rpad(l_customer_t(i).name,20,' ') || 
            rpad(l_customer_t(i).address,40,' ') || 
            rpad(l_customer_t(i).phone,14,' '));
    
    end loop;
    
    exception
        when others then
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
end;

set serveroutput on;
exec test_1;

-- 2.
select * from book;

-- 동일도서 없으면
insert into book values(20,'데이터베이스','한빛',30000);
-- 동일도서 있으면

-- 동일 도서 유무체크    
select count(*)
    from book
    where bookname = '데이터베이스'
    and publisher = '한빛';
    
-- 동일 도서 있으면
update book
    set price = 40000
    where bookname = '데이터베이스'
    and publisher = '한빛;

delete from book where bookid=20;    
commit;
exec text_2(20,'데이터베이스','한빛',30000);
exec text_2(20,'데이터베이스','한빛',40000);
select * from book;    

-- 3
select ( select name
            from customer
            where custid = t1.custid) "name",
            sum(t2.saleprice)"sum"
    from customer t1, orders t2
    where t1.custid = t2.custid(+)
    group by t1.custid
    having ( select name
            from customer
            where custid = t1.custid) = '박지성';
    
    
select t1.name,
        sum(t2.saleprice)    
    from customer t1, orders t2
    where t1.custid = t2.custid
    group by t1.name
    having t1.name = '박지성';    

-- 함수 실행 테스트2    
var g_grade varchar2;
exec : g_grade := grade('홍길동');
print g_grade;

-- 4.   
select name,grade(name)
    from customer;
    
-- 5.
select t1.custid, t1.name, count(*),nvl(sum(t2.saleprice),0)
    from customer t1, orders t2
    where t1.custid = t2.custid(+)
    group by t1.custid, t1.name;
    
-- 6.

-- 1) 테이블 생성
drop table orders_log;
create table orders_log(
  no            number,             -- 기본키
  orderid       number(2),          -- 주문번호    
  old_custid    number(2),          -- old
  old_bookid    number(2),
  old_saleprice number(8),
  old_orderdate date,
  new_custid    number(2),          -- now
  new_bookid    number(2),
  new_saleprice number(8),
  new_orderdate date,
  udate        timestamp,                -- 변경일시
  envet_type    varchar2(10)        -- 'inserting,updating,deleting'
  
);    
alter table orders_log add constraint orders_log_no primary key(no);

-- 2) 시퀀스 생성
create sequence orders_log_no_seq;

-- 3) order 테이블에 insert,upatemdelete해보기

-- insert
select * from orders;
insert into orders values ( 20, 1, 1, 30000,sysdate);
insert into orders values ( 21, 2, 2, 20000,sysdate);
select * from orders_log;

-- update
update orders
    set bookid = 3, saleprice = 30000
    where orderid = 21;
update orders
    set bookid = 3, saleprice = 40000
    where orderid = 21;    

--delete
delete from orders where orderid = 21;
select * from orders_log;    
delete from orders_log;
commit;
rollback;

select *
    from orders_log
    where orderid = 21
    order by udate;
    
-- 7.
select nvl(t3.publisher, '총계')"출판사",
        nvl(t2.name,'소계')"고객명",
        sum(t1.saleprice)"판매액"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    group by rollup(t3.publisher, t2.name)
    order by t3.publisher, t2.name;
    
-- 8.
select t1.publisher "출판사", nvl(sum(t2.saleprice),0)"총판매금액",
        rank() over(order by nvl(sum(t2.saleprice),0)desc)"순위"
    from book t1, orders t2
    where t1.bookid = t2.bookid(+)
    group by t1.publisher; 