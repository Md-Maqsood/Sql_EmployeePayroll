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

#UseCase6

alter table employee_payroll add gender char(1) after name;
update employee_payroll set gender='F' where name='Terisa';
update employee_payroll set gender='M' where name='Bill' or name='Charlie';

#UseCase7

select gender, avg(salary) from employee_payroll group by gender;
select gender, sum(salary) from employee_payroll group by gender;
select gender, min(salary) from employee_payroll group by gender;
select gender, max(salary) from employee_payroll group by gender;

#Usecase8

alter table employee_payroll add phone_number varchar(250) after name;
alter table employee_payroll add address varchar(250) after phone_number;
alter table employee_payroll add department varchar(150) not null  after address;
alter table employee_payroll alter address set default 'ABC';
insert into employee_payroll (name, department, salary, start) values ('Mike', 'Sales', 1000000.00, '2018-01-03');

#UseCase9

alter table employee_payroll rename column salary to basic_pay;
alter table employee_payroll add deductions double not null after basic_pay;
alter table employee_payroll add taxable_pay double not null after deductions;
alter table employee_payroll add tax double not null after taxable_pay;
alter table employee_payroll add net_pay double not null after tax;

#UseCase10

update employee_payroll set department='Sales' where name='Terisa';
insert into employee_payroll (name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) values
('Terisa', 'Marketing', 'F', 30000000.00, 10000000.00, 20000000.00, 5000000.00, 15000000.00, '2018-11-03');

#UseCase11

create table company(
company_id int unsigned not null auto_increment,
company_name varchar(150) not null,
primary key(company_id)
);

insert into company (company_name) values ('Capgemini');
insert into company (company_name) values ('Bridgelabs');

create table employee(
employee_id int unsigned not null auto_increment,
name varchar(150) not null,
company_id int unsigned not null,
gender char(1),
address varchar(250) not null,
phone_number varchar(150) not null,
start date not null, 
primary key (employee_id),
foreign key (company_id) references company(company_id)
);

alter table employee alter address set default 'ABC';

create table department(
department_id int unsigned not null auto_increment,
department_name varchar(150) not null,
primary key(department_id)
);

create table employee_department(
employee_id int unsigned not null,
department_id int unsigned not null,
foreign key (employee_id) references employee(employee_id),
foreign key (department_id) references department(department_id)
);

create table payroll(
employee_id int unsigned not null,
basic_pay double not null,
deductions double not null,
taxable_income double not null,
tax double not null,
net_pay double not null,
foreign key (employee_id) references employee(employee_id)
);

insert into employee (name, company_id, gender, phone_number) values ('Bill', 1, 'M', '7894561232');
insert into employee (name, company_id, gender, phone_number) values ('Charlie', 1, 'M', '7894561232');
insert into employee (name, company_id, gender, phone_number) values ('Terisa', 1, 'F', '9894561242');

insert into department (department_name) values ('Sales');
insert into department (department_name) values ('Marketing');

insert into employee_department (employee_id, department_id) values (1, 2);
insert into employee_department (employee_id, department_id) values (2, 1);
insert into employee_department (employee_id, department_id) values (3, 1);
insert into employee_department (employee_id, department_id) values (3, 2);

insert into payroll (employee_id, basic_pay, deductions, taxable_income, tax, net_pay) values 
(1, 10000000.00, 2000000.00,8000000.00,1000000.00,7000000.00);
insert into payroll (employee_id, basic_pay, deductions, taxable_income, tax, net_pay) values 
(2, 20000000.00, 4000000.00,16000000.00,3000000.00,13000000.00);
insert into payroll (employee_id, basic_pay, deductions, taxable_income, tax, net_pay) values 
(3, 30000000.00, 10000000.00,2000000.00,5000000.00,15000000.00);


select gender, avg(net_pay) from 
(employee inner join payroll on employee.employee_id=payroll.employee_id)
group by gender;

#Usecase12

select * from (employee inner join payroll on employee.employee_id=payroll.employee_id);
select net_pay from (employee inner join payroll on employee.employee_id=payroll.employee_id) where name='Bill';
select * from (employee inner join payroll on employee.employee_id=payroll.employee_id) where 
start between cast('2018-01-01' as date) and date(now());
select gender, avg(net_pay) from 
(employee inner join payroll on employee.employee_id=payroll.employee_id)
group by gender;
select gender, sum(net_pay) from 
(employee inner join payroll on employee.employee_id=payroll.employee_id)
group by gender;
select gender, min(net_pay) from 
(employee inner join payroll on employee.employee_id=payroll.employee_id)
group by gender;
select gender, max(net_pay) from 
(employee inner join payroll on employee.employee_id=payroll.employee_id)
group by gender;


