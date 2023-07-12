create table student (
    id  int not null,
    name char(20) not null,
    age  int,
    height int,
    weight  float,
    primary key(id) 
) ENGINE=InnoDB DEFAULT CHARSET =utf8;

insert into student values(10, 'Kim', 40, 170, 68);
insert into student values(20, 'Lee', 30, 175, 74);
insert into student values(30, 'Park', 40, 165, 58);
insert into student values(40, 'Choi', 50, 184, 87);

select * from student;

## 각 속성에 맞는 값들을 이용해 row를 채워갔고 마지막에 채워진 테이블을 보여준다.

insert into student values(40, 'Chung', 50, 154, null); 
## 기본키인 id에서 이미 들어있는 40을 처리하려고 함. 따라서 다른 번호로 변경을 해줘야 한다.

insert into student values(50, 2000, 'Chung', 154, null);
## age 속성에서 들어가야하는 값은 int 타입이어야 하나 char 타입으로 입력하였기 때문에 문제가 발생하였다.

insert into student values(50, 'Chung', 30, 154, null);
## 오류가 발생하지 않았으나 만약 위의 값이 실행이 되었을 경우 id 기본키에서 문제가 발생하였을 수 있다.

insert into student values(null, 'Lim', 50, 162, null);
## id에는 null 값을 할당할 수 없게 되어있으나 할당을 시도하여 에러가 발생하였다.

select * from student;
## 따라서 위의 SQL 문 중 세번째 문만 실행되어 id=50인 row가 추가되어 테이블에 나타난다.

select name, age from student where height >= 170 and weight <= 80;
## height가 170 이상인 경우와 weight가 80 이하인 경우를 가진 row 집합에서 name과 age가 나타났다.

select max(height), avg(height), min(height) from student;
## height의 최대 값과 평균, 최소 값이 나타났다.

select age, avg(height), avg(weight) from student group by age;
## age를 기준으로 해당 age의 height의 평균과 weight의 평균이 나타났다.

update student set age = 45, height = 165 where id = 30;
## id=30인 row의 age와 height를 변경하였다.

select * from student;
## id=30인 row에서 해당 값이 반영된 것을 확인할 수 있다.

delete from student where age <= 40;
## age가 40 이하인 row를 모두 지웠다.

select * from student;
## 전과 달리 age가 40 이상인 경우만 나타난다.

delete from student;
## 실행 전 모든 데이터를 지울 것인지 경고창이 나타났다.

select * from student;
## 데이터가 모두 사라진 것을 볼 수 있다.

drop table student;
## 마찬가지로 경고가 떴으며 테이블을 지울 것인지를 물어보았다.

select * from student;
## 해당 테이블이 존재하지 않는다는 에러가 밠생한다.
