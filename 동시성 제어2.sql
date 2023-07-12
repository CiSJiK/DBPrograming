select * from std_heap2;
set autocommit = 0;
set sql_safe_updates = 0;
set TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
## 작업 준비 완료
## 작업 시작
select name from std_heap2 where stid = 101;
## name = 'XX XXXX' 2단계
update std_heap2 set name = 'ZZ ZZZZ' where stid = 101;
## name = 'ZZ ZZZZ'가 되기 위해 대기중. 4단계
commit;
## name = 'ZZ ZZZZ' 락이 끝난 뒤 값이 업데이트 되었고 커밋이 되었음.

## 2
select name from std_heap2 where stid = 101;
## 4 Lock으로 인한 대기
update std_heap2 set name = 'BB BBBB' where stid = 101;
## 7 Lock 해제
commit;
## 8
select name from std_heap2 where stid = 101;
## 9
commit;

## 3 name = 'BB BBBB'로 읽음
select name from std_heap2 where stid = 101;
## 5
select name from std_heap2 where stid = 101;
## 7
commit;

## 1
set transaction ISOLATION LEVEL READ COMMITTED;
## 4 이전 버전 읽기
select name from std_heap2 where stid = 101;
## 7
commit;





















## 이미 고립성 레벨이 read committed임. 따라서 사전 설정 X
set TRANSACTION ISOLATION LEVEL READ COMMITTED;
## 1
select name from std_heap2 where stid = 101;
## 3 지금 변경 값을 가져오지 않았음.
select name from std_heap2 where stid = 101;
## 4 이후 변경된 값으로 읽을 수 있음
commit;
## 5
select name from std_heap2 where stid = 101;
commit;

## 반복 읽기로 변경
set TRANSACTION ISOLATION LEVEL REPEATABLE READ;
## 1
select name from std_heap2 where stid = 101;
## 3 이전 버전을 읽음
select name from std_heap2 where stid = 101;
## 4
commit;
## 5 DD DDDD를 읽음.
select name from std_heap2 where stid = 101;
## 6
commit;





















## 트랜잭션 고립성 단계 변경
set TRANSACTION ISOLATION LEVEL REPEATABLE READ;
## 1
select stid, name from std_heap2 where stid >= 102 and stid <= 105;
## 4 103번이 표시되지 아니함.
select stid, name from std_heap2 where stid >= 102 and stid <= 105;
## 5 
commit;

## SERIALIZABLE로 변경
set TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
## 2 LOCKKED
select stid, name from std_heap2 where stid >= 102 and stid <= 105;
## 5
select stid, name from std_heap2 where stid >= 102 and stid <= 105;	
## 6
commit;