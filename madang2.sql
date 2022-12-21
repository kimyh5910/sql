--1번
select name"이름",address"주소",phone"연락처"
from customer;

--2번
select name,address
from customer
where address like '대한민국 %';

--3번
select name,phone
from customer
where phone is null;

--4번
select count(distinct publisher)
from book;

--5번
select bookname
from book
where bookname like '골프%';

--6
select sum(custid)"주문건수",
        sum(saleprice)총매출, 
        avg(saleprice) "판매 평균", 
        max(saleprice)"최대판매액",
        min(saleprice)"최소판매액"
from orders;

--7
select publisher"출판사",count(bookid)"도서건수"
from book
group by publisher
order by count(bookid) desc;

--8
select publisher,count(bookid),max(price),min(price),sum(price)
from book
group by publisher
order
--9
select max(price) - min(price)
from book;

--10
select custid,count(*)
from orders
group by custid
having count(*) >= 2
order by custid;

--11
select orderid "주문번호"
from orders
where orderdate not between '20200704' and '20200707';

--12
select orderdate"주문일자",sum(saleprice)"매출액"
from orders
group by orderdate
order by sum(saleprice)desc;

--13
select orderdate"주문일자",sum(saleprice)"매출액"
from orders
where orderdate > '20200702'
group by orderdate
having sum(saleprice) > 20000
order by orderdate desc;

--14
select publisher"출판사",count(bookid)"도서건수"
from book
group by publisher
having count(bookid) >= 2;

--15
insert into book values(11,'데이터베이스','한빛',300000);
commit;
select * from book;

--16
update book
    set publisher = '대한출판사'
    where publisher = '대한미디어';
commit;    
select * from book;    

--17
update book
    set price = price * 1.1;
    where publisher = '굿스포츠';
commit;      
select * from book;

--18
update customer 
    set address = '대한민국 울산'
    where name = '추신수';
commit;
select * from customer;

--19
delete from customer
    where phone is null;
commit;
select * from customer;
--20
delete from customer where name = '박지성';
-- 자식 테이블에서 고객테이블에 박지성 고객의 튜블(행)을 참조하고 있어 참조 무결성 제약조건에 위배된다.


