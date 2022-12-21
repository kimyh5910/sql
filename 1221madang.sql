select t1. * , t2.*, t3.*
    from customer t1, orders t2, book t3;
    
select *
    from customer t1, orders t2
where t1.custid = t2.custid;        

select *
    from customer t1, orders t2, book t3
    where t2.custid = t1.custid
    and t2.bookid = t3.bookid;
    
-- ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.    
select *
    from customer,orders
    where customer.custid = orders.custid;

-- ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
select * 
from customer,orders
    where customer.custid = orders.custid
    order by customer.custid;

-- ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
select name,saleprice
    from customer,orders
    where customer.custid = orders.custid;
    
-- ������ �ֹ��� ��� ������ ���Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select name,sum(saleprice)
    from customer,orders
    where customer.custid = orders.custid
    group by customer.name
    order by customer.name;
    
-- ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select custmoer.name, book.bookname
    from customer,orders,book
    where customer.custid = orders.custid
    and orders.bookid = book.bookid;


-- inner join

-- case 1)
select *
    from customer t1, orders t2, book t3
    where t2.custid = t1. custid
    and t2.bookid = t3.bookid;
    
-- case 2)  
select *
from customer t1 inner join orders t2
                        on t1.custid = t2.custid
                        inner join book t3
                        on t2.bookid = t3.bookid;
                       
-- left outer join                        
select *
    from customer t1, orders t2
    where t1.custid = t2.custid(+);
    
select *
    from customer t1 left outer join orders t2
                      on t1.custid = t2.custid;        
-- right outer join    
select *
    from customer t1, orders t2
    where t1.custid(+) = t2.custid;
    
select *
    from customer t1 right outer join orders t2
                      on t1.custid = t2.custid;            
                        
-- full outer join
select *
    from customer t1, orders t2
    where t1.custid = t2.custid(+)
union    
select *
    from customer t1, orders t2
    where t1.custid(+) = t2.custid;                        
                        
select *
    from customer t1 full outer join orders t2
                      on t1.custid = t2.custid;           
                      
-- ���� ��� ������ �̸��� ���̽ÿ�.
select bookname
    from book
    where price=(select max(price)
                        from book);

                      
-- ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.                      
select name 
    from Customer
    where custid in(select custid from orders);

-- ���ѹ̵��� ������ ������ ������ ���� �̸��� ���̽ÿ�.
select name
    from customer
    where custid in(select custid
                    from orders
                    where bookid in(select bookid
                                    from book
                                    where publisher='���ѹ̵��'));

-- �����������
-- ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
select t1.bookname
    from book t1
    where t1.price > ( select avg(t2.price)   
                        from book t2
                        where t2.publisher = t1.publisher);    
            
-- ���տ���(������ union, ������ minus, ������ intersect)
-- ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.(������ �ֹ����� ���� �� = ���� - ������ �ֹ��� ��)
select name 
    from customer
minus
select name
    from customer
    where custid in(select custid from orders);    
    
-- exists
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select name,address
    from customer cs
    where exists (select *
                 from orders od
                 where cs.custid = od.custid);
                                  
                                     
                        
-- �������� (p.195)                        
-- 1) �������� ������ ������ ���ǻ� ��
select count(t3.publisher)"���ǻ� ��"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '������';
    
select count(t3.publisher)"���ǻ� ��"
    from orders t1 inner join customer t2
                    on t1.custid = t2.custid
                    inner join book t3
                    on t1.bookid = t3.bookid
    where t2.name = '������';    
    
select count(publisher)"���ǻ� ��"
    from book
    where bookid in(select bookid
                    from orders
                    where custid in (select custid 
                                    from customer
                                    where name = '������'));

select count(publisher)"���ǻ� ��"
    from book
    where bookid in(select bookid
                    from orders t1, customer t2
                    where t1.custid = t2.custid
                    and t2.name = '������');
    
-- 2) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
select t3.bookname"�����̸�",t3.price"����", (t3.price - t1.saleprice)"������ �ǸŰ��� ����"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '������';

-- 3) �������� �������� ���� ������ �̸�
select bookname
    from book
minus
select bookname
    from book
    where bookid in (select bookid
                    from orders
                    where custid in(select custid
                                    from customer
                                    where name = '������'));

-- ������ minus                                    
select bookname
    from book
minus
select bookname                                    
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '������';
    
-- not in
select bookname 
    from book
    where bookid not in (select t1.bookid
                    from orders t1, customer t2
                    where t1.custid = t2.custid
                    and t2.name = '������');
                    
-- not exists
select t1.bookname
    from book t1
    where not exists ( select t2.bookid
                        from orders t2, customer t3
                        where t2.custid = t3.custid
                        and t2.bookid = t1.bookid
                        and t3.name = '������');

-- left outer join
select distinct t1.bookname
    from book t1, orders t2, customer t3
    where t1.bookid = t2.bookid(+)
    and t2.custid = t3.custid(+)
    and (t3.name <> '������' or t3.name is null);
    
select distinct t1.bookname
    from book t1 left outer join orders t2
    on t1.bookid = t2.bookid
    left outer join customer t3
    on t2.custid = t3.custid
    where(t3.name <> '������' or t3.name is null);    


-- 4) �ֹ����� ���� ���� �̸�(�μ����� ���)

-- not exists
select t1.name
    from customer t1
    where not exists ( select *
                        from orders t2
                        where t2.custid = t1.custid);
                        
-- not in
select t1.name
    from customer t1
    where t1.custid not in(select t2.custid
                                from orders t2);

-- left outer join
select t1.name, t2.orderid
    from customer t1, orders t2
    where t1.custid = t2.custid(+)
    and t2.orderid is null;

select t1.name, t2.orderid
    from customer t1 left outer join orders t2
    on t1.custid = t2.custid
    where t2.orderid is null;

select name 
    from customer
minus
select name
    from customer
    where custid in(select custid from orders);  

-- 5) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
select sum(saleprice)"�Ѿ�",
        avg(saleprice)"���",
        sum(slaeprice)/count(saleprice)"���2"
    from orders;

-- 6) ���� �̸��� ���� ���ž�
select t2.name "����", sum(t1.saleprice) "���ž�"
    from orders t1, customer t2
    where t1.custid = t2.custid
    group by t1.custid, t2.name;
    
-- 7) ���� �̸��� ���� ������ ���� ���
select t2.name, t3.bookname
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid;

-- 8) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
select t3.orderid "�ֹ���ȣ"
    from orders t3, book t4
    where t3.bookid = t4.bookid
    and t4.price - t3.saleprice = (select max(t2.price - t1.saleprice)
                                        from orders t1, book t2
                                        where t1.bookid = t2.bookid);


-- 9) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
select t2.name"����"
    from orders t1, customer t2
    where t1.custid = t2.custid
    group by t2.custid, t2.name
    having avg(t1.saleprice) > ( select avg(saleprice)
                                    from orders);

            
-- 10) �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�
select name
    from customer t1, book t2, orders t3
    where t1.custid = t3.custid
    and t2.bookid = t1.bookid
    and t1.name = '������';

    


-- 11) �ΰ� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�

-- 12) ��ü ���� 30% �̻��� ������ ����
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
