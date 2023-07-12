use mydb;
show tables;

set @a=100;
set @b=200;
set @c=@a + @b;
select @a, @b, @c;

set @a = 500; 
set @b =300; 
set @c = @a - @b;
select @a, @b, @c;

set @x = 20;
set @y = 5;
set @z = @x * @y;
select @x, @y, @z;

drop procedure if exists add_sum;
delimiter $$ ##시작점
create procedure add_sum() ## 함수와의 차이점: return 값이 없으면 프로시저, 있으면 함수.
begin 
    declare a int;
    declare b int;
    declare c int;
    set a = 200; set b = 700; set c = a + b;
    select a, b, c;
end $$
delimiter ;##끝점

call add_sum;
call add_sum;
select @a;
select a; ## 지역 변수이므로 확인 불가.
call add_sum;

drop procedure if exists minus_proc;
delimiter $$
create procedure minus_proc ( )
begin
    declare x int;  declare y int; declare z int;
    set x = 50; set y = 35; set z = x - y; 
    select x, y, z; 
end $$
delimiter ;

call minus_proc;
call minus_proc;

select @a, @b, @c;
select x, y, z;
select @x, @y, @z;

drop procedure if exists minus_proc2;
delimiter $$
create procedure minus_proc2 (IN s int, IN t int)
begin
    declare u int;  
    set u = s - t;  
    select s, t, u; 
end $$
delimiter ;

call minus_proc2(200, 150);
call minus_proc2(5000, 2550);
call minus_proc2(30, 10);

call minus_proc;
call minus_proc;

DELIMITER $$
CREATE PROCEDURE score(IN d int)
BEGIN
    IF d >= 90 THEN SELECT 'A 입니다.';
    ELSEIF d >= 80 THEN SELECT 'B 입니다.';
    ELSEIF d >= 70 THEN SELECT 'C 입니다.';
    ELSEIF d >= 60 THEN SELECT 'D 입니다.';
    ELSE SELECT 'F 입니다.';
    END IF;
END $$
DELIMITER ;

CALL score(86);
CALL score(72);
CALL score(94);
CALL score(66);
CALL score(58);

drop procedure if exists oper_proc;
delimiter $$
create procedure oper_proc (IN s int, IN op char, IN t int)
begin
      declare u int;  
      case
	when op = '+' then set u = s + t;
	when op = '-' then set u = s - t;
	when op = '*' then set u = s * t;
	when op = '/' then set u = s / t;
	else set u = -10000;
     end case;
     select s, op, t, '=', u;
end $$
delimiter ;

call oper_proc (100, '+', 50);
call oper_proc (250, '-', 120);
call oper_proc (10, '*', 5);
call oper_proc (400, '/', 80);  

### 임의의 호출문을 4개 이상 작성하여 실행하기 

drop procedure if exists times;
delimiter $$
create procedure times(in x int, in y int)
begin
	declare z int;
	set z = x * y;
	select x, y, z;
end $$
delimiter ;

call times(20, 5);
call times(30, 255);

drop procedure if exists toSecond;
delimiter $$
create procedure toSecond(in m int)
begin
	declare s int;
	set s = m * 60;
	select m as 'Min', 'to', s as 'Sec';
end $$
delimiter ;

call toSecond(1);
call toSecond(5);

drop procedure if exists newUser;
delimiter $$
create procedure newUser(in comp text, out r bool)
begin
	if comp = 'st' then
		set r = true;
	else
		set r = false;
	end if;
	select r;
end $$
delimiter ;

call newUser('as', @r);
select @r;
call newUser('st', @r);
select @r;

##root 계정에서 실행 필요.

drop procedure if exists createUser;
delimiter $$
create procedure createUser(in id char(20), in admin bool)
begin
	declare s text;
	declare t text;
	set s = concat('create user ', id,'@','localhost');
	select s;
	if admin = true then
		set t = concat('grant all privileges on *.* to ', s);
	else
		set t = concat('grant all privileges on mydb.* to ', s);
	end if;
	select t;
end $$
delimiter ;
