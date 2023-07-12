create table dept 
( dno int not null, 
dname char(20) not null, 
mgreno int, 
mgrstartdate char(10), 
primary key(dno) ) 
ENGINE=InnoDB 
DEFAULT CHARSET =utf8; 

insert into dept values(1, 'Research', 109, '15-JAN-99');
insert into dept values(2, 'Sales', 105, '25-MAR-97');
insert into dept values(3, 'Develop', 102, '06-MAR-98');
insert into dept values(4, 'Administration', 110, '25-APR-96');
insert into dept values(5, 'Research', 104, '10-APR-97');

create table emp
( eno int not null,
ename char(20) not null,
sex char(1),
salary int,
dno int,
primary key(eno),
foreign key(dno) references dept(dno) )
ENGINE=InnoDB
DEFAULT CHARSET =utf8;

insert into emp values(100, 'John Smith', 'M', 10000, 1);
insert into emp values(101, 'Franklin Wong', 'M', 25000, 1);
insert into emp values(102, 'Alicia Zela', 'F', 30000, 1);
insert into emp values(103, 'Jennifer Wall', 'F', 18000, 2);
insert into emp values(104, 'Ramesh Nara', 'M', 24000, 2);
insert into emp values(105, 'Joyce English', 'F', 32000, 3);
