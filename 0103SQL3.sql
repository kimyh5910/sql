select name,address,phone
    from customer
    where address like'%���ѹα�%';
    
create or replace procedure test_1
-- (
    -- �Ű�����
--)    

as
    -- ��������
    type customer_rec_t is record(
        name    customer.name%type,
        address customer.address%type,
        phone   customer.phone%type
    );
    type customer_table_t is table of customer_rec_t
        index by binary_integer;
    
    l_customer_t    customer_table_t;
begin
    -- ���๮
    select name,address,phone
        bulk collect into l_customer_t
        from customer
    where address like '%���ѹα�%';
    
    
    for i in 1..l_customer_t.count loop
        dbms_output.put_line(
            rpad(l_customer_t(i).name,20,' ') || 
            rpad(l_customer_t(i).address,40,' ') || 
            rpad(l_customer_t(i).phone,14,' '));
    
    end loop;
    
    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;

set serveroutput on;
exec test_1;

-- 2.
select * from book;

-- ���ϵ��� ������
insert into book values(20,'�����ͺ��̽�','�Ѻ�',30000);
-- ���ϵ��� ������

-- ���� ���� ����üũ    
select count(*)
    from book
    where bookname = '�����ͺ��̽�'
    and publisher = '�Ѻ�';
    
-- ���� ���� ������
update book
    set price = 40000
    where bookname = '�����ͺ��̽�'
    and publisher = '�Ѻ�;

delete from book where bookid=20;    
commit;
exec text_2(20,'�����ͺ��̽�','�Ѻ�',30000);
exec text_2(20,'�����ͺ��̽�','�Ѻ�',40000);
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
            where custid = t1.custid) = '������';
    
    
select t1.name,
        sum(t2.saleprice)    
    from customer t1, orders t2
    where t1.custid = t2.custid
    group by t1.name
    having t1.name = '������';    

-- �Լ� ���� �׽�Ʈ2    
var g_grade varchar2;
exec : g_grade := grade('ȫ�浿');
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

-- 1) ���̺� ����
drop table orders_log;
create table orders_log(
  no            number,             -- �⺻Ű
  orderid       number(2),          -- �ֹ���ȣ    
  old_custid    number(2),          -- old
  old_bookid    number(2),
  old_saleprice number(8),
  old_orderdate date,
  new_custid    number(2),          -- now
  new_bookid    number(2),
  new_saleprice number(8),
  new_orderdate date,
  udate        timestamp,                -- �����Ͻ�
  envet_type    varchar2(10)        -- 'inserting,updating,deleting'
  
);    
alter table orders_log add constraint orders_log_no primary key(no);

-- 2) ������ ����
create sequence orders_log_no_seq;

-- 3) order ���̺� insert,upatemdelete�غ���

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
select nvl(t3.publisher, '�Ѱ�')"���ǻ�",
        nvl(t2.name,'�Ұ�')"����",
        sum(t1.saleprice)"�Ǹž�"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    group by rollup(t3.publisher, t2.name)
    order by t3.publisher, t2.name;
    
-- 8.
select t1.publisher "���ǻ�", nvl(sum(t2.saleprice),0)"���Ǹűݾ�",
        rank() over(order by nvl(sum(t2.saleprice),0)desc)"����"
    from book t1, orders t2
    where t1.bookid = t2.bookid(+)
    group by t1.publisher; 