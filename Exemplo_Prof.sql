show databases;
create database  if not exists exemplo_prof;
use exemplo_prof;
create table person(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	gender enum('M', 'F'),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);
desc person;

create table favorite_food(
person_id smallint unsigned,
food varchar(20),
constraint pk_favorite_food primary key (person_id, food),
constraint pk_favorite_food_person_id foreign key (person_id) references person(person_id)
);

desc favorite_food;

show databases;

select * from information_schema.table_constraints;

select * from information_schema.table_constraints
where constraint_schema='first_example';

select constraint_name from information_schema.table_constraints
where table_name = 'person';

desc person;

insert into person values('1','Leticia','Oliveira','F', '1993-05-26',' sem numero', 'Cidade S','SP','Brasil', '26501-02');
insert into person values('2','Carolina','Silva', 'F','1979-08-12', 'rua tal', 'Cidade J', 'SP','Brasil', '26501-02');
insert into person values('3', 'Lucas', 'Oliveira', 'M','2019-10-25', 'rua', 'Cidade S', 'SP', 'Brasil', '5151-02');
insert into person values('4', 'Oliveira', 'Oliveira', 'M','2019-10-25', 'rua', 'Cidade S', 'SP', 'Brasil', '5151-02'),
						('5', 'Silva', 'Oliveira', 'M','2019-10-25', 'rua', 'Cidade S', 'SP', 'Brasil', '5151-02');
select * from person;

delete from person where person_id=2
					or person_id=4;

select * from person;
desc favorite_food;











