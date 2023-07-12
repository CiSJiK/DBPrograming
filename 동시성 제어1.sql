## 사전 작업
create table std_heap2(
	stid int,
	name char(20), 
	grade int,
	age int,
	addr char(60),
	dno int
)engine=InnoDB;

set autocommit = 0;
set sql_safe_updates = 0;
set TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

insert into std_heap2 values (101, 'JS Kim', 3, 22, 'Chuncheon', 3);
insert into std_heap2 values (102, 'PK Lee', 2, 21, 'Seoul', 1);
insert into std_heap2 values (105, 'AB Park', 2, 20, 'Wonju', 2);
insert into std_heap2 values (106, 'CD Hwang', 1, 19, 'Chuncheon', 2);
insert into std_heap2 values (110, 'XY Choi', 2, 21, 'Seoul', 3);
update std_heap2 set name = 'XX XXXX', grade = 9 where stid = 101;
update std_heap2 set name = 'BB BBBB', grade = 8 where stid = 102;
commit;

select * from std_heap2;

##사전 작업 완료(테이블 생성, 값 대입)

## 작업 시작
select name from std_heap2 where stid = 101;
## name = 'XX XXXX' 1단계
update std_heap2 set name = 'YY YYYY' where stid = 101;
## name = 'YY YYYY' 3단계
select name from std_heap2 where stid = 101;
## 결과 name = 'YY YYYY' 5단계
commit;
## 커밋 됨. 6단계. 이후 4단계를 다시 해보면 커밋이 됨.




















## 1
select name from std_heap2 where stid = 101;
## 3 Locked
update std_heap2 set name = 'AA AAAA' where stid = 101;
## 5
rollback;
## 6
select name from std_heap2 where stid = 101;
## 10 name = 'BB BBBB'
commit;





















## 허상 읽기 다만 다중버전이므로 방지됨을 확인
## 1
select name from std_heap2 where stid = 101;
## 2 새버전 'CC CCCC' 생성
update std_heap2 set name = 'CC CCCC' where stid = 101;
## 4
rollback;
## 6
select name from std_heap2 where stid = 101;
## 8 결과 name = 'BB BBBB'
commit;

## 허상 읽기 방지
## 2
select name from std_heap2 where stid = 101;
## 3
update std_heap2 set name = 'CC CCCC' where stid = 101;
## 5
rollback;
## 6
select name from std_heap2 where stid = 101;
## 8
commit;





















## 비 반복적 읽기 발생
## 2
update std_heap2 set name = 'CC CCCC' where stid = 101;
## 2-1 의도하지 않은 오류가 발생. 상대에서 커밋을 해버리면 커밋된 값을 읽어오기에 비반복적 읽기에 해당 안함.
commit;


## 2
update std_heap2 set name = 'DD DDDD' where stid = 101;
commit;





















## 	유령 레코드 발생
## 2
insert into std_heap2 values (103, 'KK KKKK', 3, 20, 'Chuncheon', 2);
## 3
commit;

## 1
delete from std_heap2 where stid = 103;
commit;
## 3 2번에 의해 삽입 대기
insert into std_heap2 values (103, 'KK KKKK', 3, 20, 'Chuncheon', 2);
## 4 삽입 이후 실행.
commit;