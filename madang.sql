select * from book;
select bookname, publisher from book;

select bookname, publisher
    from book
where price >= 10000;   

select phone, address, name
    from customer
    where name = '김연아';
    
select *
    from customer;
    
SELECT BOOKNAME, PRICE
FROM BOOK;

SELECT BOOKID,BOOKNAME,PUBLISHER,PRICE
FROM BOOK;

SELECT *
FROM BOOK;

SELECT *
FROM BOOK
WHERE PRICE < 20000;

SELECT *
FroM BOOK
where not(10000 <= price and price <= 20000);

select *
from book
where publisher in('굿스포츠','대한미디어');

select * from customer;

select *
from customer
where phone is null;

-- 내림차순=desc  가격은 내림차순 가격이 같으면 출판사로 오름차순
select *
from book
order by price desc, publisher asc;

select * from book;

select publisher, sum(price)
from book
group by publisher;

select * from orders;

select sum(saleprice)총매출, 
        avg(saleprice) "판매 평균", 
        max(saleprice)"최대판매액",
        min(saleprice)"최소판매액"
from orders;

select COUNT(custid)"고객 수"
from customer;

select count(bookid) "2만원 이상인 도서 수"
from book
where price >= 20000;


-- 출판사 개수 구하기
select * from book;

select count( distinct publisher )
from book;




select custid,count(*) 도서수량, sum(saleprice)총액
from orders
group by custid;

select * from customer;

select count(*)
from customer;

select count(custid)
from customer;

select count(phone) -- 박세리 번호가 null이여서 4
from customer;


-- 판매가가 8천원 이상인것
select *
from orders
where saleprice >= 8000;


select custid,count(*)
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2
order by custid;

-- 도서번호가 1인 도서의 이름
select  bookname"도서명"
from book
where bookid = 1;

-- 가격이 20000원 이상인 도서의 이름
select bookname,price"도서명"
from book
where price >= 20000;


-- 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
select sum(saleprice)" 총 구매액"
from orders
where custid = 1;


-- 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
select count(custid)"도서 수"
from orders
where custid = 1;

-- 마당서점 도서의 총 개수
select count(bookid)"총 도서 개수"
from book;

-- 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) " 출판사 총수"
from book;

-- 모든 고객의 이름, 주소
select name"이름", address"주소"
from customer;

-- 2020년 7월 4일 ~ 7월7일 사이에 주문 받은 도서의 주문번호
select orderid "주문번호"
from orders
where orderdate between '20200704' and '20200707';

-- 2020 년 7월 4일 ~ 7월7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
select orderid "주문번호"
from orders
where orderdate not between '20200704' and '20200707';

-- 성이 '김' 씨인 고객의 이름과 주소
select name"이름", address"주소"
from customer
where name like '김%';

-- 성이 '김' 씨이고 이름이 '아' 로 끝나는 고개의 이름과 주소
select name"이름", address"주소"
from customer
where name like '김%아';



