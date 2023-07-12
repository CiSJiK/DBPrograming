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

