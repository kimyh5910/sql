--6
select sum(custid)"주문건수",
        sum(saleprice)총매출, 
        avg(saleprice) "판매 평균", 
        max(saleprice)"최대판매액",
        min(saleprice)"최소판매액"
from orders;

--7
select publisher
from book
order by publisher desc;

--8

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
select orderdate,saleprice
from orders
order by orderdate desc,saleprice desc;

--13
select orderdate,saleprice
from orders
where orderdate > '20200702' and saleprice > 20000;

--14
select publisher,count(*)"도서건수"
from book
where bookid > 2
group by publisher
having count(*) >= 2;


--15
select * from book;
insert into book values(11,'데이터베이스','한빛',300000);




