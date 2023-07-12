use company;
set sql_safe_updates = 0;
show tables;

### department 테이블에 아래 2개의 튜플을 추가하기
insert into department values('영업부', 7, '333445555', '1990-01-01');
insert into department values('비서실', 8, '999887777', '2010-01-01');
select * from department;

### dept_locations 테이블에 7번 부서의 위치 3개를 추가하기.

insert into dept_locations values(7, '서울');
insert into dept_locations values(8, '춘천');
insert into dept_locations values(8, '판교');

select * from dept_locations;

### works_on 테이블에 튜플 5개를 추가함.

insert into works_on values('987987987', 20, 7.3);
insert into works_on values('888665555', 10, 7.3);
insert into works_on values('333445555', 30, 7.3);
insert into works_on values('999887777', 1, 7.3);
insert into works_on values('453453453', 3, 7.3);

select * from works_on;

### 30000 이상의 salary를 받는 사원의 fname, lname, bdate 검색하기.

select fname, lname, bdate from employee e where salary >= 30000;

###  5번 부서에 근무하는 사람 중에서 30000 이상 salary를 받는 사원의 fname, lname, bdate 검색하기.

select fname, lname, bdate from employee e where dno=5 and salary >= 30000;

### 'Research' 부서에 근무하는 사원의 fname, lname, bdate 검색하기.

select fname, lname, bdate from employee e, department d where e.dno=d.dnumber and d.dname='Research';

### 일반 중첩 질의를 사용하여, 'Research' 부서에 근무하는 사원들의 fname, lname, bdate 검색하기

select fname, lname, bdate from employee where dno in 
(select dnumber from department where dname='Research');

### exists 연산자를 사용하는 상관 중첩 질의를 사용하여, 'Research' 부서에 근무하는 사원들의 fname, lname, bdate 검색하기
select fname, lname, bdate from employee e where EXISTS (select * from department d where dname = 'Research' and d.dnumber = e.dno);

### 'ProjectX' 프로젝트에 참여하는 사원의 이름(fname, lname), 프로젝트의 위치(Plocation), 주당참여시간(Hours)을 검색하기.

select fname, lname, plocation, hours from employee e, project p, works_on w 
where p.pname='ProductX' and p.pnumber=w.pno and w.essn=e.ssn;

### 일반 중첩 질의를 사용하여, 부양가족이 있는 사원들의 fname, lname, bdate 검색하기

select fname, lname, bdate from employee e where e.ssn in (select essn from dependent d);

### 일반 중첩 질의를 사용하여, 부양 가족이 없는 사원들의 fname, lname, bdate 검색하기
select fname, lname, bdate from employee e where e.ssn not in (select essn from dependent d);

### 상관 중첩 질의를 사용하여, 부양 가족이 없는 사원들의 fname, lname, bdate 검색하기
select fname, lname, bdate from employee e where e.ssn not in (select essn from dependent d where d.essn = e.ssn);

### 내부 조인을 사용하여, 사원들의 이름과 부양가족의 이름을 검색하기 
select fname, lname, dependent_name from employee inner join dependent on ssn=essn;

### 조인된 테이블 사용하여 위 질의를 수정함
select d.fname, d.lname, d.dependent_name from (select fname, lname, dependent_name from dependent, employee where employee.ssn = dependent.essn) d;

### 왼쪽 outer join을 사용하여, 사원들의 이름과 부양가족의 이름을 검색하기
select fname, lname, dependent_name from employee e left outer join dependent d on e.ssn=d.essn where dependent_name is not null;

