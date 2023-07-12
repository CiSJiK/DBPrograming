show databases;
use company;
show tables;

select * from employee;
select * from department;
select * from project;
select * from works_on;

delimiter $$
create or replace PROCEDURE getDnum(in pnum int)
BEGIN 
	select dnum from project where pnum=pnumber;
END $$
delimiter ;

call getDnum(1);
call getDnum(10);
call getDnum(30);

select * from project;
select * from employee;

delimiter $$
create or replace PROCEDURE getEname(in cssn char(9))
BEGIN 
	select fname, lname from employee where ssn=cssn;
END $$
delimiter ;

call getEname('123456789');
call getEname('453453453');
call getEname('888665555');

delimiter $$
create or replace procedure setSalary(in cssn char(9), out sal double)
BEGIN
	declare insal int;
	select salary into insal from employee where ssn=cssn;
	set sal = insal * 1.1;
END $$
delimiter ;

call setSalary('123456789', @res);
call setSalary('453453453', @ult);
call setSalary('888665555', @here);
select @res, @ult, @here;

delimiter $$
create or replace procedure totalMax(in dnum int, out total_sal int, out cnt int)
BEGIN 
	declare sal int;
	declare counts int;
	declare eol boolean default false;
	declare cur cursor for
		select salary from employee where dno=dnum;
	declare continue handler for not found set eol=true;
	set total_sal=0;
	set cnt=0;
	
	open cur;
	loop_do: loop
		fetch cur into sal;
		if eol then
			leave loop_do;
		end if;
		
		set total_sal = total_sal+sal;
		set cnt = cnt + 1;
	end loop loop_do;
	close cur;
END $$
delimiter ;

call totalMax(5, @sal, @cnt);
select @sal, @cnt;
call totalMax(1, @sal, @cnt);
select @sal, @cnt;
call totalMax(4, @sal, @cnt);
select @sal, @cnt;

select * from department;

delimiter $$
create or replace procedure deptAvgSal(in name varchar(15), out avgsal double)
BEGIN 
	declare sal int;
	declare total_sal int;
	declare counts int;
	declare eol boolean default false;
	declare cur cursor for
		select salary from employee e, department d where d.dname=name and e.dno = d.dnumber;
	declare continue handler for not found set eol=true;
	set total_sal=0;
	set counts=0;
	
	open cur;
	loop_do: loop
		fetch cur into sal;
		if eol then
			leave loop_do;
		end if;
		
		set total_sal = total_sal+sal;
		set counts = counts + 1;
	end loop loop_do;
	close cur;
	set avgsal = total_sal / counts;
END $$
delimiter ;

call deptAvgSal ('Headquarters', @res);
select @res;
call deptAvgSal ('Administration', @res);
select @res;
call deptAvgSal ('Research', @res);
select @res;

delimiter $$
create or replace function getdeptavgsal (name varchar(15)) returns double
BEGIN 
	declare avgsal double;
	declare sal int;
	declare cnt int;
	declare eol boolean default false;
	declare cur cursor for
		select salary from employee e, department d where dname = name and d.dnumber=e.dno;
	declare continue handler for not found set eol = true;
	set avgsal = 0;
	set cnt = 0;
	open cur;
	loop_do: loop
		fetch cur into sal;
		if eol then
			leave loop_do;
		end if;
		
		set avgsal = avgsal + sal;
		set cnt = cnt + 1;
	end loop loop_do;
	close cur;
	set avgsal = avgsal / cnt;
	return avgsal;
END $$
delimiter ;

select getdeptavgsal('Headquarters');
select getdeptavgsal('Administration');
select getdeptavgsal('Research');

create table department_backup (
num int auto_increment,
dname varchar(15) not null,
dnumber int not null,
mgr_ssn char(9) not null,
mgr_start_date date,
modType char(10),
modeDate date,
modeUser varchar(256),
primary key(num),
unique(dname)
) engine=InnoDB default charset = utf8;

select * from department_backup;

delimiter //
create or replace trigger backDept_UpdateTrg 
	before update 
	on department 
	for each row
begin 
	insert into department_backup values (null, old.dname, old.dnumber, old.mgr_ssn, old.mgr_start_date, '수정', curdate(), current_user());
end //
delimiter ;

select * from department ;

update department set dname = 'Research6' where dnumber = 5;
update department set dname = 'Research' where dnumber = 5;
select * from department_backup;

delimiter //
create or replace trigger backDept_DeleteTrg
	before DELETE 
	on department
	for each ROW 
	BEGIN 
		insert into department_backup values(null, old.dname, old.dnumber, old.mgr_ssn, old.mgr_start_date, '삭제', curdate(), current_user());
	END //
delimiter ;
	
delete from department where dnumber = 6;
insert into department values('a', 10, '12356389', '2020-04-27');
delete from department where dnumber=10;

select * from department_backup;
