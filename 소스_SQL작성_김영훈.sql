--6
select sum(custid)"�ֹ��Ǽ�",
        sum(saleprice)�Ѹ���, 
        avg(saleprice) "�Ǹ� ���", 
        max(saleprice)"�ִ��Ǹž�",
        min(saleprice)"�ּ��Ǹž�"
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
select orderid "�ֹ���ȣ"
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
select publisher,count(*)"�����Ǽ�"
from book
where bookid > 2
group by publisher
having count(*) >= 2;


--15
select * from book;
insert into book values(11,'�����ͺ��̽�','�Ѻ�',300000);




