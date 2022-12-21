select * from book;

insert into book(bookid, bookname, publisher)
    values(14,'������ ����', '�Ѽ����м���');
commit;    

insert into book(bookid,bookname,price,publisher)
    select bookid,bookname,price,publisher
    from imported_book;
    
select * from imported_book;    
commit;

update customer
    set address = '���ѹα� �λ�'
where custid = 5;    
commit;

select * from customer;
rollback;

update customer 
set address = ( select address
                        from customer
                        where name = '�迬��')
where name = '�ڼ���';
commit;

delete from customer where custid = 5;
select * from customer;
commit;



SELECT * FROM ORDERS;

CREATE table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key(bookid)
);

create table newbook2(
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookname,publisher)
);    

create table newbook3(
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check(price > 1000),
    primary key (bookname,publisher)
);

insert into newbook3(bookname,publisher,price)
    values('�����ͺ��̽�','�Ѻ�',100);
 insert into newbook3(bookname,publisher)
    values('�����ͺ��̽�',null);
    
select * from newbook3;    
rollback;

create table newcustomer(
    custid number primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(30)
);

create table neworders(
    orderid number,
    custid number not null,
    bookid number not null,
    saleprice number,
    orderdate date,
    primary key(orderid),
    foreign key(custid) references newcustom(custid) on delete cascade
    );
    
insert into newcustomer
    values(1,'ȫ�浿',��� ����','010-1234-5678');
commit;
select * from newcustomer;

delete from newcustomer where custid = 1;

    
insert into neworders
    values(1,1,1,10000,sysdate);
select * from newsorders;    
    
