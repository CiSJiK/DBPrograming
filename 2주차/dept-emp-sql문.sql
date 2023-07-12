#### 단순 질의
select ename, salary, dno from emp
## emp 테이블의 모든 row를 ename, salary, dno만 나타내게 했다.

select ename, salary from emp where salary >=20000
## salary가 20000이상인 row를 emp 테이블에서 골라 ename, salary 속성을 가진 row만 출력하였다.

select ename, salary from emp where salary >=20000 and dno = 2
## 이전 SQL 문에서 dno가 2인 row만 출력하였다.

select dno from dept where dname = 'Research'
## dname이 Research인 row를 골라 dno 속성을 가진 row들만 출력하였다.

## 조인질의
select dname, ename from emp, dept where mgreno = eno;
## mgreno와 eno가 같은 값을 가진 경우의 row만 출력하였다. 이때 eno는 dept의 mgreno와 대응된다.

select ename, dname from emp, dept where emp.dno = dept.dno and dname='Research';
## emp와 dept의 조인을 이용하여 양 테이블의 dno를 기준으로 조인시킨 후 dname이 Research인 값을 가진 row들을 ename, dname 속성만 출력하였다. 

#### 중첩질의
select ename, salary from emp where dno in 
                                    (select dno from dept where dname = 'Research')
## dname이 Research인 row만 가져온 리스트에 있는 dno 값이 포함된 row들을 emp 테이블에서 선택하여 ename과 salary로 구성된 결과를 표현하였다.                                    

select ename, salary from emp where exists 
	(select * from dept where dno = emp.dno and dname = 'Research');
## 앞서 했던 쿼리와 같은 결과를 나타내나 emp 테이블에 있는 dno와 dept 테이블에 있는 dno가 일치하고 해당 dname이 Research인 리스트만 가져와 존재하는 경우	의 리스트를 나타내었다.	

select ename, salary from emp where dno not in 
                                    (select dno from dept where dname = 'Research')
## 앞서 했던 쿼리와 달리 해당 결과를 제외한 row만 남은 테이블이 나타났다.                                     

#### 집계질의
select dno, max(salary), avg(salary), min(salary)  from emp  group by dno
## 각 dno를 기준으로 salary의 최대값, 평균값, 최소값들의 결과가 나타났다.

select dname, count(*), avg(salary) 
from emp, dept 
where emp.dno = dept.dno 
group by dname
## dno를 기준으로 조인된 테이블에서 각 dname을 기준으로 해당 dname이 포함된 row수와 해당 dname의 평균 salary 값들의 결과가 나타났다.

select dname, count(*), avg(salary)   
from emp, dept 
where emp.dno = dept.dno 
group by dname
having count(*) >= 2
## 위와 비슷하나 해당 dname이 포함된 row 수가 2 이상인 경우만을 나타나게 하였다.

#### 갱신문
update emp set salary = salary * 1.1 where dno = 1;
## dno가 1인 row의 salary를 1.1배로 올렸다.
select * from emp
##따라서 기존 dno가 1인 row들의 salary 값이 각각 1.1만, 2.75만, 3.3만으로 변경되었다.

update emp 
set salary = salary * 1.1
where dno in (select dno from dept where dname = 'Research');
select * from emp
## 중첩 질의를 통해 dname이 Research인 dno 값들의 리스트를 기반으로 해당 dno를 가진 row의 salary 값을 1.1배 시켜 위의 결과에서 또 1.1배를 하였다.

insert into emp values (106, 'Jeniffer Widom', 'F', 50000, 6); ## 오류 발생 - 참조 무결성 규칙 위반(dept 테이블에 dno가 6인 row가 존재 X)

delete from dept where dno = 1       ## 오류 발생 - 참조무결성규칙 위반(참조된 값을 사용중일 경우 연달아서 삭제가 불가능함)

update dept set dno = 7 where dno = 1        ## 오류 발생 - 참조무결성규칙 위반

#### 뷰(View) 정의 및 활용
create view emp_dept as
select ename, salary, dname from emp, dept where emp.dno = dept.dno;
select * from emp_dept
## 새로운 뷰를 만들어서 ename, salary, dname만 나오는 뷰가 생성되었다.

select ename, salary from emp_dept where dname = 'Research'
## 해당 뷰에서 dname이 Research인 경우만 나타내었다.

insert into emp_dept values('Larry King', 65000, 'sales')
## 뷰에는 값을 대입할 수 없음을 알 수 있다.

update emp_dept set salary = 70000 where ename = 'John Smith'
## 다만 수정은 가능함을 알 수 있다.