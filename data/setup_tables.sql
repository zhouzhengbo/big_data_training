drop table if exists emp_basic; 
create table if not exists emp_basic (
emp_id int,emp_name string,job_title string,company string,start_date date,quit_date date
)
row format delimited
fields terminated by ',';

drop table if exists emp_psn; 
create table if not exists emp_psn (
emp_id int,address string,city string,phone string,email string,gender char(1),age int
)
row format delimited
fields terminated by ',';

drop table if exists emp_bef; 
create table if not exists emp_bef (
emp_id int,sin string,salary decimal(10,2),payroll string,level varchar(2)
)
row format delimited
fields terminated by ',';

load data local inpath 'emp_basic.csv' overwrite into table emp_basic;
load data local inpath 'emp_psn.csv' overwrite into table emp_psn;
load data local inpath 'emp_bef.csv' overwrite into table emp_bef;

drop table if exists employee; 
create table if not exists employee (
name string,work_place array<string>,sex_age struct<sex:string,age:int>,skills_score map<string,int>,depart_title map<string,array<string>>
)
comment 'this is an internal table'
row format delimited
fields terminated by '|'
collection items terminated by ','
map keys terminated by ':';

load data local inpath 'employee.txt' overwrite into table employee;

--create external table and load the data
drop table if exists employee_external; 
create external table if not exists employee_external(
name string,work_place array<string>,sex_age struct<sex:string,age:int>,skills_score map<string,int>,depart_title map<string,array<string>>
)
comment 'this is an external table'
row format delimited
fields terminated by '|'
collection items terminated by ','
map keys terminated by ':'
location '/tmp/employee';

load data local inpath 'employee.txt' overwrite into table employee_external;

drop table if exists employee_hr;
create table if not exists employee_hr(name string,employee_id int,sin_number string,start_date date
)
row format delimited
load data local inpath 'employee_hr.txt' overwrite into table employee_hr;

drop table if exists employee_id;
create table if not exists employee_id(
name string,work_place array<string>,sex_age struct<sex:string,age:int>,skills_score map<string,int>,depart_title map<string,array<string>>
)
row format delimited
fields terminated by '|'
collection items terminated by ','
map keys terminated by ':';

load data local inpath 'employee_id.txt' overwrite into table employee_id;

drop table if exists employee_contract;
create table if not exists employee_contract(
name string,dept_num int,employee_id int,salary int,type string,start_date date
)
row format delimited
fields terminated by '|'
stored as textfile;

load data local inpath 'employee_contract.txt' overwrite into table employee_contract;

drop table if exists employee_partitioned;
create table if not exists employee_partitioned(
name string,work_place array<string>,sex_age struct<sex:string,age:int>,skills_score map<string,int>,depart_title map<string,array<string>>
)
partitioned by (year int, month int)
row format delimited
fields terminated by '|'
collection items terminated by ','
map keys terminated by ':';

drop table if exists employee_id_buckets;
create table if not exists employee_id_buckets(
name string,employee_id int,work_place array<string>,sex_age struct<sex:string,age:int>,skills_score map<string,int>,depart_title map<string,array<string>>
)
clustered by (employee_id) into 2 buckets
row format delimited
fields terminated by '|'
collection items terminated by ','
map keys terminated by ':';

drop table if exists twitter;
create table if not exists twitter(
userid string,time string,latitude string,longitude string,tweet string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ("input.regex"="(.{14})(.{20})(.{10})(.{12})(.{1,})");

load data local inpath 'tweet_ful.txt' overwrite into table twitter;