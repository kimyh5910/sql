select t1. * , t2.*, t3.*
    from customer t1, orders t2, book t3;
    
select *
    from customer t1, orders t2
where t1.custid = t2.custid;        

select *
    from customer t1, orders t2, book t3
    where t2.custid = t1.custid
    and t2.bookid = t3.bookid;
    
-- 고개과 고객의 주문에 관한 데이터를 모두 보이시오.    
select *
    from customer,orders
    where customer.custid = orders.custid;

-- 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
select * 
from customer,orders
    where customer.custid = orders.custid
    order by customer.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select name,saleprice
    from customer,orders
    where customer.custid = orders.custid;
    
-- 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오.
select name,sum(saleprice)
    from customer,orders
    where customer.custid = orders.custid
    group by customer.name
    order by customer.name;
    
-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
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
                      
-- 가장 비싼 도서의 이름을 보이시오.
select bookname
    from book
    where price=(select max(price)
                        from book);

                      
-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오.                      
select name 
    from Customer
    where custid in(select custid from orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select name
    from customer
    where custid in(select custid
                    from orders
                    where bookid in(select bookid
                                    from book
                                    where publisher='대한미디어'));

-- 상관부족질의
-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select t1.bookname
    from book t1
    where t1.price > ( select avg(t2.price)   
                        from book t2
                        where t2.publisher = t1.publisher);    
            
-- 집합연산(합집합 union, 차집합 minus, 교집합 intersect)
-- 도서를 주문하지 않은 고객의 이름을 보이시오.(도서를 주문하지 않은 고객 = 모든고객 - 도서를 주문한 고객)
select name 
    from customer
minus
select name
    from customer
    where custid in(select custid from orders);    
    
-- exists
-- 주문이 있는 고객의 이름과 주소를 보이시오.
select name,address
    from customer cs
    where exists (select *
                 from orders od
                 where cs.custid = od.custid);
                                  
                                     
                        
-- 연습문제 (p.195)                        
-- 1) 박지성이 구매한 도서의 출판사 수
select count(t3.publisher)"출판사 수"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '박지성';
    
select count(t3.publisher)"출판사 수"
    from orders t1 inner join customer t2
                    on t1.custid = t2.custid
                    inner join book t3
                    on t1.bookid = t3.bookid
    where t2.name = '박지성';    
    
select count(publisher)"출판사 수"
    from book
    where bookid in(select bookid
                    from orders
                    where custid in (select custid 
                                    from customer
                                    where name = '박지성'));

select count(publisher)"출판사 수"
    from book
    where bookid in(select bookid
                    from orders t1, customer t2
                    where t1.custid = t2.custid
                    and t2.name = '박지성');
    
-- 2) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select t3.bookname"도서이름",t3.price"가격", (t3.price - t1.saleprice)"정가와 판매가격 차이"
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '박지성';

-- 3) 박지성이 구매하지 않은 도서의 이름
select bookname
    from book
minus
select bookname
    from book
    where bookid in (select bookid
                    from orders
                    where custid in(select custid
                                    from customer
                                    where name = '박지성'));

-- 차집합 minus                                    
select bookname
    from book
minus
select bookname                                    
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid
    and t2.name = '박지성';
    
-- not in
select bookname 
    from book
    where bookid not in (select t1.bookid
                    from orders t1, customer t2
                    where t1.custid = t2.custid
                    and t2.name = '박지성');
                    
-- not exists
select t1.bookname
    from book t1
    where not exists ( select t2.bookid
                        from orders t2, customer t3
                        where t2.custid = t3.custid
                        and t2.bookid = t1.bookid
                        and t3.name = '박지성');

-- left outer join
select distinct t1.bookname
    from book t1, orders t2, customer t3
    where t1.bookid = t2.bookid(+)
    and t2.custid = t3.custid(+)
    and (t3.name <> '박지성' or t3.name is null);
    
select distinct t1.bookname
    from book t1 left outer join orders t2
    on t1.bookid = t2.bookid
    left outer join customer t3
    on t2.custid = t3.custid
    where(t3.name <> '박지성' or t3.name is null);    


-- 4) 주문하지 않은 고객의 이름(부속질의 사용)

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

-- 5) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice)"총액",
        avg(saleprice)"평균",
        sum(slaeprice)/count(saleprice)"평균2"
    from orders;

-- 6) 고객의 이름과 고객별 구매액
select t2.name "고객명", sum(t1.saleprice) "구매액"
    from orders t1, customer t2
    where t1.custid = t2.custid
    group by t1.custid, t2.name;
    
-- 7) 고객의 이름과 고객이 구매한 도서 목록
select t2.name, t3.bookname
    from orders t1, customer t2, book t3
    where t1.custid = t2.custid
    and t1.bookid = t3.bookid;

-- 8) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select t3.orderid "주문번호"
    from orders t3, book t4
    where t3.bookid = t4.bookid
    and t4.price - t3.saleprice = (select max(t2.price - t1.saleprice)
                                        from orders t1, book t2
                                        where t1.bookid = t2.bookid);


-- 9) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select t2.name"고객명"
    from orders t1, customer t2
    where t1.custid = t2.custid
    group by t2.custid, t2.name
    having avg(t1.saleprice) > ( select avg(saleprice)
                                    from orders);

            
-- 10) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select name
    from customer t1, book t2, orders t3
    where t1.custid = t3.custid
    and t2.bookid = t1.bookid
    and t1.name = '박지성';

    


-- 11) 두개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

-- 12) 전체 고객의 30% 이상이 구매한 도서
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
