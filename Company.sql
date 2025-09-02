create schema if not exists company;

create table company.employee (
	Fname varchar(15) NOT NULL,
    Minit char,
    Lname varchar(15) NOT NULL,
    Ssn char(9) NOT NULL,
    Bdate DATE,
    Address varchar(30),
    sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int NOT NULL,
    PRIMARY KEY (Ssn)
);

use company;
create table departmant (
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    primary key (Dnumber),
    unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

RENAME TABLE company.departmant TO company.department;
create table dept_locations (
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key(Dnumber, Dlocation),
    foreign key (Dnumber) references department(Dnumber)
);

RENAME TABLE company.department TO company.departament;
create table project (
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber, Plocation),
    unique (Pname),
    foreign key (Dnum) references departament(Dnumber)
);

create table works_on (
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    foreign key (Essn) references employee(Ssn),
    foreign key (Pno) references project(Pnumber)
);

create table dependent (
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    foreign key (Essn) references employee(Ssn)
);

show tables;
desc departament;

show character set;

select * from information_schema.table_constraints
where constraint_schema = 'company';

select * from information_schema.referential_constraints
where constraint_schema = 'company';

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

alter table departament drop constraint departament_ibfk_1;
alter table departament add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn) on update cascade;
alter table departament add column Mgr_dept_date date;
alter table departament rename column Mgr_dept_date to Dept_create_date;

alter table dept_locations drop constraint dept_locations_ibfk_1;
alter table dept_locations add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber) on delete cascade on update cascade;
