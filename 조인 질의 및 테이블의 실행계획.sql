create table course_heap (
	cno int,
	cname char(30),
	credit int,
	category char(20),
	lecturer char(20),
	note char(20)
)engine=InnoDB;
create table course_seq (
	cno int,
	cname char(30),
	credit int,
	category char(20),
	lecturer char(20),
	note char(20),
	primary key (cno)
)engine=InnoDB;
create table enroll_heap(
	stid int,
	cno int,
	middle int,
	final int, 
	note char(50)
)engine=InnoDB;
create table enroll_seq (
	stid int,
	cno int,
	middle int,
	final int, 
	note char(50),
	primary key(stid, cno)
)engine=InnoDB;
create table enroll_fk(
	stid int,
	cno int,
	middle int,
	final int, 
	note char(50),
	foreign key(stid) references std_seq(stid),
	foreign key(cno) references course_seq(cno)
)engine=InnoDB;
create table enroll_seqfk (
	stid int,
	cno int,
	middle int,
	final int, 
	note char(50),
	primary key(stid, cno),
	foreign key(stid) references std_seq(stid),
	foreign key(cno) references course_seq(cno)
)engine=InnoDB;

insert into course_heap values (10, 'Data Structure', 3, 'Core', 'DS Park', 'test course 1');
insert into course_heap values (12, 'Operating Systems', 3, 'Core', 'LT Kim', 'test course 3');
insert into course_heap values (11, 'Databases', 3, 'Core', 'TN Choi', 'test course 2');
insert into course_heap values (20, 'Network', 3, 'Advanced', 'NX Lee', 'test course 4');
insert into course_heap values (23, 'Compiler', 3, 'Optional', 'PK Park', 'test course 5');
insert into course_heap values (25, 'Software', 3, 'Advanced', 'IW Kim', 'test course 6');

select * from course_heap;

insert into course_seq values (10, 'Data Structure', 3, 'Core', 'DS Park', 'test course 1');
insert into course_seq values (12, 'Operating Systems', 3, 'Core', 'LT Kim', 'test course 3');
insert into course_seq values (11, 'Databases', 3, 'Core', 'TN Choi', 'test course 2');
insert into course_seq values (20, 'Network', 3, 'Advanced', 'NX Lee', 'test course 4');
insert into course_seq values (23, 'Compiler', 3, 'Optional', 'PK Park', 'test course 5');
insert into course_seq values (25, 'Software', 3, 'Advanced', 'IW Kim', 'test course 6');

select * from course_seq;

insert into enroll_heap values (118, 10, 80, 90, null);
insert into enroll_heap values (118, 12, 90, 75, 'repeat');
insert into enroll_heap values (118, 11, 78, 83, null);
insert into enroll_heap values (114, 11, 82, 79, null);
insert into enroll_heap values (114, 20, 93, 63, null);
insert into enroll_heap values (114, 23, 98, 84, null);
insert into enroll_heap values (114, 25, 65, 92, 'repeat');
insert into enroll_heap values (103, 10, 83, 78, 'repeat');
insert into enroll_heap values (103, 11, 79, 87, null);
insert into enroll_heap values (125, 10, 95, 82, null);
insert into enroll_heap values (125, 11, 89, 96, null);
insert into enroll_heap values (125, 12, 85, 82, null);
insert into enroll_heap values (106, 20, 76, 85, 'repeat');
insert into enroll_heap values (117, 11, 82, 95, null);
insert into enroll_heap values (117, 12, 84, 89, null);
insert into enroll_heap values (117, 23, 95, 84, 'repeat');
insert into enroll_heap values (117, 10, 87, 72, null);
insert into enroll_heap values (132, 10, 69, 89, null);
insert into enroll_heap values (132, 11, 89, 73, null);

select * from enroll_heap;

insert into enroll_seq values (118, 10, 80, 90, null);
insert into enroll_seq values (118, 12, 90, 75, 'repeat');
insert into enroll_seq values (118, 11, 78, 83, null);
insert into enroll_seq values (114, 11, 82, 79, null);
insert into enroll_seq values (114, 20, 93, 63, null);
insert into enroll_seq values (114, 23, 98, 84, null);
insert into enroll_seq values (114, 25, 65, 92, 'repeat');
insert into enroll_seq values (103, 10, 83, 78, 'repeat');
insert into enroll_seq values (103, 11, 79, 87, null);
insert into enroll_seq values (125, 10, 95, 82, null);
insert into enroll_seq values (125, 11, 89, 96, null);
insert into enroll_seq values (125, 12, 85, 82, null);
insert into enroll_seq values (106, 20, 76, 85, 'repeat');
insert into enroll_seq values (117, 11, 82, 95, null);
insert into enroll_seq values (117, 12, 84, 89, null);
insert into enroll_seq values (117, 23, 95, 84, 'repeat');
insert into enroll_seq values (117, 10, 87, 72, null);
insert into enroll_seq values (132, 10, 69, 89, null);
insert into enroll_seq values (132, 11, 89, 73, null);

select * from enroll_seq;

insert into enroll_fk values (118, 10, 80, 90, null);
insert into enroll_fk values (118, 12, 90, 75, 'repeat');
insert into enroll_fk values (118, 11, 78, 83, null);
insert into enroll_fk values (114, 11, 82, 79, null);
insert into enroll_fk values (114, 20, 93, 63, null);
insert into enroll_fk values (114, 23, 98, 84, null);
insert into enroll_fk values (114, 25, 65, 92, 'repeat');
insert into enroll_fk values (103, 10, 83, 78, 'repeat');
insert into enroll_fk values (103, 11, 79, 87, null);
insert into enroll_fk values (125, 10, 95, 82, null);
insert into enroll_fk values (125, 11, 89, 96, null);
insert into enroll_fk values (125, 12, 85, 82, null);
insert into enroll_fk values (106, 20, 76, 85, 'repeat');
insert into enroll_fk values (117, 11, 82, 95, null);
insert into enroll_fk values (117, 12, 84, 89, null);
insert into enroll_fk values (117, 23, 95, 84, 'repeat');
insert into enroll_fk values (117, 10, 87, 72, null);
insert into enroll_fk values (132, 10, 69, 89, null);
insert into enroll_fk values (132, 11, 89, 73, null);

select * from enroll_fk;

insert into enroll_seqfk values (118, 10, 80, 90, null);
insert into enroll_seqfk values (118, 12, 90, 75, 'repeat');
insert into enroll_seqfk values (118, 11, 78, 83, null);
insert into enroll_seqfk values (114, 11, 82, 79, null);
insert into enroll_seqfk values (114, 20, 93, 63, null);
insert into enroll_seqfk values (114, 23, 98, 84, null);
insert into enroll_seqfk values (114, 25, 65, 92, 'repeat');
insert into enroll_seqfk values (103, 10, 83, 78, 'repeat');
insert into enroll_seqfk values (103, 11, 79, 87, null);
insert into enroll_seqfk values (125, 10, 95, 82, null);
insert into enroll_seqfk values (125, 11, 89, 96, null);
insert into enroll_seqfk values (125, 12, 85, 82, null);
insert into enroll_seqfk values (106, 20, 76, 85, 'repeat');
insert into enroll_seqfk values (117, 11, 82, 95, null);
insert into enroll_seqfk values (117, 12, 84, 89, null);
insert into enroll_seqfk values (117, 23, 95, 84, 'repeat');
insert into enroll_seqfk values (117, 10, 87, 72, null);
insert into enroll_seqfk values (132, 10, 69, 89, null);
insert into enroll_seqfk values (132, 11, 89, 73, null);

select * from enroll_seqfk;

show index from std_heap;
show index from std_seq;
show index from std_hash;
show index from std_index;

show index from course_heap;
show index from course_seq;

show index from enroll_heap;
show index from enroll_seq;
show index from enroll_fk;
show index from enroll_seqfk;

explain select * from std_heap where stid = 132;
explain select * from std_seq where stid = 132;
explain select * from std_index where stid = 132;
explain select * from std_heap where age = 22;
explain select * from std_seq where age = 22;
explain select * from std_index where age = 22;

explain select * from enroll_heap where stid = 114;
explain select * from enroll_seq where stid = 114;
explain select * from enroll_fk where stid = 114;
explain select * from enroll_seqfk where stid = 114;

explain select * from enroll_heap where cno = 11;
explain select * from enroll_seq where cno = 11;
explain select * from enroll_fk where cno = 11;
explain select * from enroll_seqfk where cno = 11;

explain select * from enroll_heap where stid = 114 and cno = 11;
explain select * from enroll_seq where stid = 114 and cno = 11;
explain select * from enroll_fk where stid = 114 and cno = 11;
explain select * from enroll_seqfk where stid = 114 and cno = 11;