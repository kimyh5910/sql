select round(3.14,1)
    from dual;
    
select round(1234,-1)
    from dual;
    
select length('홍길동'),lengthb('홍길동')
    from dual;

select length('student'), lengthb('student')
    from dual;
    
select add_months('20221216',1)
    from dual;
    
select add_months(to_date('20221216','yyyy-mm-dd'),1)
    from dual;
    
select add_months(sysdate,1)
    from dual;
    
-- 주어진 날짜 달의 마지막일    
select last_day(sysdate)
    from dual;
    
-- 내년 2월의 마지막 날짜
select last_day(add_months(sysdate,2))
    from dual;
    
select to_char(sysdate,'yyyy-mm-dd hh:mm:ss')
    from dual;
    
select to_char(sysdate,'d')
    from dual;
    
select *from customer;
select * from book;
select * from orders;

insert into customer values(6,'홍길동','울산 남구','');
insert into customer values(7,'홍길동2','울산 남구',null);
insert into customer values(9,'홍길동4 ','울산 남구',' ');

select * from customer where name = ('홍길동4 ');
rollback;

-- 가상테이블(null값에 무슨값을 계산을 해도 결과는 null)
with tmp as (
    select null from dual;
)

with tmp as(
    select 1 as col from dual
    union
    select 2 from dual
    union
    select 3 from dual
    union
    select null from dual
)
select avg(col) from tmp;

select count(phone)
    from customer;

with tmp2 as (
    select null col from dual
)
select avg(col) from tmp2;

with mybook as(
    select 1 as bookid, 10000 as price from dual
        union
    select 2, 20000 from dual
    union
    select 3, null from dual
)
select price + 100
    from mybook
where bookid = 3;    

-- null 값 표시
select name "이름", nvl(phone,'연락쳐없음') "전화번호"
    from customer;

select rownum, t1.*
    from customer t1
where address like '%대한민국%'
    and rownum <= 3;     -- 첫번째 행부터 나오는 수식만 가능
    
select rownum, t1.*
    from book t1
    where rownum <= 5;
    
    
select rownum, t1.*
    from book t1
    where rownum <= 5
    order by price;    
    
select t2.*,rownum 순위
    from ( select t1.*
            from book t1
        order by price desc) t2
    where rownum <= 3;
    
select t1.name
    from customer t1
    where not exists ( select *
                    from orders t2
                    where t2.custid = t1.custid);
                    
select t1.name, sum(t2.saleprice)"total"
    from (select custid, name
            from customer 
            where custid <= 2) t1,
        orders t2
    where t1.custid = t2.custid
group by t1.name;

select  custid,(select address
                from Customer cs
                where cs.custid = od.custid)"address",
                     SUM(saleprice)"total"
from orders od
group by od.custid;

select cs.name,s
    from (select custid,avg(saleprice)s
            from orders
            group by custid)od,customer cs
    where cs.custid = od.custid;        
    
select sum(saleprice)"total"
    from orders od
    where exists(select *
                from customer cs
                where custid <=3 and cs.custid = od.custid);
                
                
create view order_view as                
select t1.orderid,
        t2.custid, t2.name,t2.phone,
        t3.bookname, t3.publisher, t3.price, t1.saleprice
    from orders t1,customer t2, book t3
    where t1.custid = t2.custid
    and  t1.bookid = t3.bookid;

select name, sum(saleprice),
        (select phone
        from customer t1 
        where t1.custid = order_view.custid) phone
    from order_view
group by custid, name
order by sum(saleprice) desc;

-- 뷰 생성
create view vw_customer
as select *
    from customer
    where address like'%대한민국%';
    
select *
    from vw_customer;
    
-- 뷰 수정    
create or replace view vw_customer(custid,name,address)
as select custid, name, address
from customer
where address like '%영국%';

select * 
from vw_customer;

-- 뷰 삭제
drop view vw_customer;

select * 
from vw_customer;



create view vw_highorders
as select t1.bookid,t1.bookname,t3.name,t1.publisher,t2.saleprice
    from book t1,orders t2, customer t3
    where t1.bookid = t2.bookid
    and t2.custid = t3.custid
    and t2.saleprice >= 20000;
    
select bookname,name from vw_highorders;

create or replace view vw_highorders 
    as select *
        from vw_highorders
        where name like '박%';
        
create index ix_book on book(bookname);

create index ix_book2 on book(publisher ,price);

select *
    from book
    where publisher = '대한미디어' and price >= 30000;
    
drop index ix_book2;    

alter index in_book rebuild;

select name from customer where name like'박세리';

select name
    from customer;

drop index name;

