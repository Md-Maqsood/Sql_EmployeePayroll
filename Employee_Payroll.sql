#UseCase1

create database payroll_database;
show databases;
use payroll_service;

#UseCase2

create table employee_payroll(
id int unsigned not null auto_increment,
name varchar(150) not null,
salary double not null,
start date not null,
primary key (id)
);

#UseCase3

insert into employee_payroll(name, salary, start) values
('Bill', 10000000.00, '2018-01-03'),
('Terisa', 20000000.00, '2018-11-03'),
('Charlie', 30000000.00, '2020-05-21');

#UseCase4

select * from employee_payroll;

#UseCase5

select salary from employee_payroll where name='Bill';
select * from employee_payroll where start between cast('2018-01-01' as date) and date(now());

