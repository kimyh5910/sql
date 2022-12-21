--1��
select name"�̸�",address"�ּ�",phone"����ó"
from customer;

--2��
select name,address
from customer
where address like '���ѹα� %';

--3��
select name,phone
from customer
where phone is null;

--4��
select count(distinct publisher)
from book;

--5��
select bookname
from book
where bookname like '����%';

--6
select sum(custid)"�ֹ��Ǽ�",
        sum(saleprice)�Ѹ���, 
        avg(saleprice) "�Ǹ� ���", 
        max(saleprice)"�ִ��Ǹž�",
        min(saleprice)"�ּ��Ǹž�"
from orders;

--7
select publisher"���ǻ�",count(bookid)"�����Ǽ�"
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
select orderid "�ֹ���ȣ"
from orders
where orderdate not between '20200704' and '20200707';

--12
select orderdate"�ֹ�����",sum(saleprice)"�����"
from orders
group by orderdate
order by sum(saleprice)desc;

--13
select orderdate"�ֹ�����",sum(saleprice)"�����"
from orders
where orderdate > '20200702'
group by orderdate
having sum(saleprice) > 20000
order by orderdate desc;

--14
select publisher"���ǻ�",count(bookid)"�����Ǽ�"
from book
group by publisher
having count(bookid) >= 2;

--15
insert into book values(11,'�����ͺ��̽�','�Ѻ�',300000);
commit;
select * from book;

--16
update book
    set publisher = '�������ǻ�'
    where publisher = '���ѹ̵��';
commit;    
select * from book;    

--17
update book
    set price = price * 1.1;
    where publisher = '�½�����';
commit;      
select * from book;

--18
update customer 
    set address = '���ѹα� ���'
    where name = '�߽ż�';
commit;
select * from customer;

--19
delete from customer
    where phone is null;
commit;
select * from customer;
--20
delete from customer where name = '������';
-- �ڽ� ���̺��� �����̺� ������ ���� Ʃ��(��)�� �����ϰ� �־� ���� ���Ἲ �������ǿ� ����ȴ�.


