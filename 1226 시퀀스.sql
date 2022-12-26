drop table member;
create table member(
    member_id   number(5),          -- 회원아이디
    email       varchar2(30),        -- 이메일
    passwd      varchar2(10),       -- 비밀번호
    nickname        varchar2(30)   -- 별칭    
);

alter table member add constraint member_member_id_pk primary key(member_id);

insert into member values(1,'test@test.com',1234,'닉네임1');
insert into member values(2,'test@test.com',1234,'닉네임2');
insert into member values(3,'test@test.com',1234,'닉네임3');

commit;

select * from member;

-- 시퀀스 객체 생성
create sequence member_member_id_seq
    increment by -2  -- 시퀀스 번호 증가값, 기본값은 1
    start with 10    -- 시퀀스 시작번호, 기본값은 1
    maxvalue 10    -- 생성가능한 시퀀스 최대값
    minvalue 1    -- 생성가능한 시퀀스 최소값
    cycle         -- 시퀀스번호를 순환 사용할 것인지 지정 [cycle : nocycle]  
    cache 2;       -- 시퀀스 생성속도를 개선하기 위해 캐싱여부 지정

-- 시퀀스 삭제
drop sequence member_member_id_seq;
    
-- 시퀀스번호 생성    
select member_member_id_seq.nextval
    from dual;
-- 현재 시퀀스 번호 조회    
select member_member_id_seq.currval
    from dual;
    
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'닉네임1');
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'닉네임2');
insert into member values(member_member_id_seq.nextval,'test@test.com',1234,'닉네임3');        

select * from member;