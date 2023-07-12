create table std_heap (
	stid int,
	name char(20),
	grade int,
	age int,
	addr char(60),
	dno int
)engine=InnoDB;

create table std_seq (
	stid int,
	name char(20),
	grade int,
	age int,
	addr char(60),
	dno int,
	primary key (stid)
)engine=InnoDB;

create table std_hash (
	stid int,
	name char(20),
	grade int,
	age int,
	addr char(60),
	dno int,
	INDEX ix_stid (stid) using HASH
)engine=MEMORY;

create table std_index (
	stid int,
	name char(20),
	grade int,
	age int,
	addr char(60),
	dno int
)engine=InnoDB;

create index ix_name on std_index(name);
create unique index ix_stid on std_index(stid);
create index ix_age using hash on std_index(age);

insert into std_heap values (118, 'JS Kim 118', 3, 22, 'chuncheon1', 3);
insert into std_heap values (114, 'JS Kim 114' ,1, 19, 'chuncheon1', 3);
insert into std_heap values (110, 'JS Kim 110', 4, 25, 'chuncheon1', 3);
insert into std_heap values (103, 'JS Kim 103', 4, 24, 'chuncheon2', 2);
insert into std_heap values (125, 'JS Kim 125', 3, 21, 'chuncheon2', 2);
insert into std_heap values (138, 'JS Kim 138', 2, 20, 'chuncheon2', 3);
insert into std_heap values (102, 'JS Kim 102', 2, 20, 'chuncheon2', 4);
insert into std_heap values (154, 'JS Kim 154', 3, 21, 'chuncheon3', 4);
insert into std_heap values (106, 'JS Kim 106', 4, 22, 'chuncheon3', 4);
insert into std_heap values (117, 'JS Kim 117', 1, 19, 'chuncheon3', 1);
insert into std_heap values (132, 'JS Kim 132', 2, 20, 'chuncheon4', 1);
insert into std_heap values (122, 'JS Kim 122', 1, 18, 'chuncheon4', 1);
insert into std_heap values (101, 'JS Kim 101', 1, 19, 'chuncheon4', 2);
insert into std_heap values (144, 'JS Kim 144', 2, 21, 'chuncheon4', 2);
insert into std_heap values (139, 'JS Kim 139', 3, 22, 'chuncheon5', 3);
insert into std_heap values (165, 'JS Kim 165', 3, 23, 'chuncheon5', 3);
insert into std_heap values (131, 'JS Kim 131', 4, 24, 'chuncheon5', 4);

select * from std_heap;

insert into std_seq values (118, 'JS Kim 118', 3, 22, 'chuncheon1', 3);
insert into std_seq values (114, 'JS Kim 114' ,1, 19, 'chuncheon1', 3);
insert into std_seq values (110, 'JS Kim 110', 4, 25, 'chuncheon1', 3);
insert into std_seq values (103, 'JS Kim 103', 4, 24, 'chuncheon2', 2);
insert into std_seq values (125, 'JS Kim 125', 3, 21, 'chuncheon2', 2);
insert into std_seq values (138, 'JS Kim 138', 2, 20, 'chuncheon2', 3);
insert into std_seq values (102, 'JS Kim 102', 2, 20, 'chuncheon2', 4);
insert into std_seq values (154, 'JS Kim 154', 3, 21, 'chuncheon3', 4);
insert into std_seq values (106, 'JS Kim 106', 4, 22, 'chuncheon3', 4);
insert into std_seq values (117, 'JS Kim 117', 1, 19, 'chuncheon3', 1);
insert into std_seq values (132, 'JS Kim 132', 2, 20, 'chuncheon4', 1);
insert into std_seq values (122, 'JS Kim 122', 1, 18, 'chuncheon4', 1);
insert into std_seq values (101, 'JS Kim 101', 1, 19, 'chuncheon4', 2);
insert into std_seq values (144, 'JS Kim 144', 2, 21, 'chuncheon4', 2);
insert into std_seq values (139, 'JS Kim 139', 3, 22, 'chuncheon5', 3);
insert into std_seq values (165, 'JS Kim 165', 3, 23, 'chuncheon5', 3);
insert into std_seq values (131, 'JS Kim 131', 4, 24, 'chuncheon5', 4);

select * from std_seq;

insert into std_hash values (118, 'JS Kim 118', 3, 22, 'chuncheon1', 3);
insert into std_hash values (114, 'JS Kim 114' ,1, 19, 'chuncheon1', 3);
insert into std_hash values (110, 'JS Kim 110', 4, 25, 'chuncheon1', 3);
insert into std_hash values (103, 'JS Kim 103', 4, 24, 'chuncheon2', 2);
insert into std_hash values (125, 'JS Kim 125', 3, 21, 'chuncheon2', 2);
insert into std_hash values (138, 'JS Kim 138', 2, 20, 'chuncheon2', 3);
insert into std_hash values (102, 'JS Kim 102', 2, 20, 'chuncheon2', 4);
insert into std_hash values (154, 'JS Kim 154', 3, 21, 'chuncheon3', 4);
insert into std_hash values (106, 'JS Kim 106', 4, 22, 'chuncheon3', 4);
insert into std_hash values (117, 'JS Kim 117', 1, 19, 'chuncheon3', 1);
insert into std_hash values (132, 'JS Kim 132', 2, 20, 'chuncheon4', 1);
insert into std_hash values (122, 'JS Kim 122', 1, 18, 'chuncheon4', 1);
insert into std_hash values (101, 'JS Kim 101', 1, 19, 'chuncheon4', 2);
insert into std_hash values (144, 'JS Kim 144', 2, 21, 'chuncheon4', 2);
insert into std_hash values (139, 'JS Kim 139', 3, 22, 'chuncheon5', 3);
insert into std_hash values (165, 'JS Kim 165', 3, 23, 'chuncheon5', 3);
insert into std_hash values (131, 'JS Kim 131', 4, 24, 'chuncheon5', 4);

select * from std_hash;

insert into std_index values (118, 'JS Kim 118', 3, 22, 'chuncheon1', 3);
insert into std_index values (114, 'JS Kim 114' ,1, 19, 'chuncheon1', 3);
insert into std_index values (110, 'JS Kim 110', 4, 25, 'chuncheon1', 3);
insert into std_index values (103, 'JS Kim 103', 4, 24, 'chuncheon2', 2);
insert into std_index values (125, 'JS Kim 125', 3, 21, 'chuncheon2', 2);
insert into std_index values (138, 'JS Kim 138', 2, 20, 'chuncheon2', 3);
insert into std_index values (102, 'JS Kim 102', 2, 20, 'chuncheon2', 4);
insert into std_index values (154, 'JS Kim 154', 3, 21, 'chuncheon3', 4);
insert into std_index values (106, 'JS Kim 106', 4, 22, 'chuncheon3', 4);
insert into std_index values (117, 'JS Kim 117', 1, 19, 'chuncheon3', 1);
insert into std_index values (132, 'JS Kim 132', 2, 20, 'chuncheon4', 1);
insert into std_index values (122, 'JS Kim 122', 1, 18, 'chuncheon4', 1);
insert into std_index values (101, 'JS Kim 101', 1, 19, 'chuncheon4', 2);
insert into std_index values (144, 'JS Kim 144', 2, 21, 'chuncheon4', 2);
insert into std_index values (139, 'JS Kim 139', 3, 22, 'chuncheon5', 3);
insert into std_index values (165, 'JS Kim 165', 3, 23, 'chuncheon5', 3);
insert into std_index values (131, 'JS Kim 131', 4, 24, 'chuncheon5', 4);

select * from std_index;

explain select * from std_heap where stid = 117;
explain select * from std_seq where stid = 117;
explain select * from std_hash where stid = 117;
explain select * from std_index where stid = 117;

explain select * from std_heap where age = 20;
explain select * from std_seq where age = 20;
explain select * from std_hash where age = 20;
explain select * from std_index where age = 20;	

