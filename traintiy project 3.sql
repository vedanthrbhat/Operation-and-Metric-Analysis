create database project3;
show databases;
use  project3;

create table job_data
(ds date,
job_id int not null,
actor_id int not null,
event varchar(50) not null,
language varchar(50) not null,
time_spent int not null,
org char(2)
);

create table users(
user_id int,
created_at varchar(100),
company_id int,
language varchar(100),
activated_at varchar(100),
state varchar(100));

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
into table users
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from users;

create table events(
user_id	int,
occurred_at varchar(100),
event_type varchar(100),
event_name varchar(100),
location varchar(100),
device varchar(100),
user_type int);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
into table events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from events;

create table email_events(
user_id	int,
occurred_at	varchar(100),
action varchar(100),
user_type int);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
into table email_events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from email_events;

insert into job_data(ds	,job_id	,actor_id	,event	,language	,time_spent	,org)
values
('2020-30-11',21,1001,'skip','English',15,'A'),
('2020-30-11',22,1006,'transfer','Arabic',25,'B'),
('2020-29-11',23,1003,'decision','Persian',20,'C'),
('2020-28-11',23,1005,'transfer','Persian',22,'D'),
('2020-28-11',25,1002,'decision','Hindi',11,'B'),
('2020-27-11',11,1007,'decision','French',104,'D'),
('2020-26-11',23,1004,'skip','Persian',56,'A'),
('2020-25-11',20,1003,'transfer','Italian',45,'C');

select * from job_data;

INSERT INTO job_data(ds, job_id, actor_id, event, language, time_spent, org)
VALUES 
('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
('2020-11-28', 23, 1005, 'transfer', 'Persian', 22, 'D'),
('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');


-- Jobs Reviewed Over Time:
-- Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
-- Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
select * from job_data;

select avg(t) as 'avg job per hr',
avg(p) as' avg job reviewed per sec'
from (
select ds,(((count(job_id)*3600)/sum(time_spent))) as t,((count(job_id))/sum(time_spent)) as p
from job_data
where month(ds)=11
group by ds) as a ;

-- Throughput Analysis:
-- Objective: Calculate the 7-day rolling average of throughput (number of events per second).
-- Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally,
--  explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
select round(count(event)/sum(time_spent),2)as 'weekly throughput' from job_data;

select ds as dates,round(count(event)/sum(time_spent),2) as 'daily througtput' from job_data
group by ds order by ds;


-- Language Share Analysis:
-- Objective: Calculate the percentage share of each language in the last 30 days.
-- Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.
select language as languages ,round(100 * count(*)/total,1)as percentage,sub.total
from job_data
cross join (select count(*) as total from job_data)as sub
group by language,sub.total;

-- Duplicate Rows Detection:
-- Objective: Identify duplicate rows in the data.
-- Your Task: Write an SQL query to display duplicate rows from the job_data table.
select actor_id,count(*) as duplicates from job_data
group by actor_id having count(*) >1;


#case study 2
select * from events;


alter table users add column temp_created_at datetime;
set sql_safe_updates=0;
update users 
set temp_created_at = str_to_date(created_at,'%d-%m-%Y %H:%i');
set sql_safe_updates=1;
alter table users drop column created_at;
alter table users change column temp_created_at created_at datetime;



alter table users add column temp_created_at datetime;
set sql_safe_updates=0;
update users 
set temp_created_at = str_to_date(activated_at,'%d-%m-%Y %H:%i');
set sql_safe_updates=1;
alter table users drop column activated_at;
alter table users change column temp_created_at activated_at datetime;


alter table email_events add column temp_created_at datetime;
set sql_safe_updates=0;
update email_events 
set temp_created_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
set sql_safe_updates=1;
alter table email_events drop column occurred_at;
alter table email_events change column temp_created_at occurred_at datetime;


alter table events add column temp_created_at datetime;
set sql_safe_updates=0;
update events 
set temp_created_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
set sql_safe_updates=1;
alter table events drop column occurred_at;
alter table events change column temp_created_at occurred_at datetime;

CREATE FUNCTION date_trunc(unit VARCHAR(10), datetime_value DATETIME)
RETURNS DATETIME
DETERMINISTIC
BEGIN
    IF unit = 'year' THEN
        RETURN STR_TO_DATE(DATE_FORMAT(datetime_value, '%Y-01-01 00:00:00'), '%Y-%m-%d %H:%i:%s');
    ELSEIF unit = 'month' THEN
        RETURN STR_TO_DATE(DATE_FORMAT(datetime_value, '%Y-%m-01 00:00:00'), '%Y-%m-%d %H:%i:%s');
    ELSEIF unit = 'week' THEN
        RETURN STR_TO_DATE(CONCAT(YEAR(datetime_value), WEEK(datetime_value, 1), ' Monday'), '%X%V %W');
    ELSEIF unit = 'day' THEN
        RETURN DATE(datetime_value);
    ELSEIF unit = 'hour' THEN
        RETURN STR_TO_DATE(DATE_FORMAT(datetime_value, '%Y-%m-%d %H:00:00'), '%Y-%m-%d %H:%i:%s');
    ELSEIF unit = 'minute' THEN
        RETURN STR_TO_DATE(DATE_FORMAT(datetime_value, '%Y-%m-%d %H:%i:00'), '%Y-%m-%d %H:%i:%s');
    ELSE
        RETURN datetime_value; -- No truncation
    END IF;
END //



-- Weekly User Engagement:
-- Objective: Measure the activeness of users on a weekly basis.
-- Your Task: Write an SQL query to calculate the weekly user engagement.

select * from events;

WITH weekly_activity AS (
    SELECT 
        user_id,
        DATE_TRUNC('week', occurred_at) AS week_start,
        COUNT(*) AS event_count
    FROM 
        events
    GROUP BY 
        user_id, DATE_TRUNC('week', occurred_at)
)
SELECT 
    week_start,
    COUNT(DISTINCT user_id) AS active_users,
    AVG(event_count) AS avg_events_per_user
FROM 
    weekly_activity
GROUP BY 
    week_start
ORDER BY 
    week_start;


-- User Growth Analysis:
-- Objective: Analyze the growth of users over time for a product.
-- Your Task: Write an SQL query to calculate the user growth for the product.
SELECT 
    DATE_TRUNC('week', activated_at) AS week_start,
    COUNT(*) AS new_users
FROM 
    users
GROUP BY 
    DATE_TRUNC('week', activated_at)
ORDER BY 
    week_start;


-- Weekly Retention Analysis:
-- Objective: Analyze the retention of users on a weekly basis after signing up for a product.
-- Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.
select * from users;
WITH cohort AS (
    SELECT 
        user_id,
        DATE_TRUNC('week', activated_at) AS cohort_week
    FROM 
        users
),
activity AS (
    SELECT 
        user_id,
        DATE_TRUNC('week', occurred_at) AS activity_week
    FROM 
        events
),
cohort_activity AS (
    SELECT 
        c.cohort_week,
        a.activity_week,
        COUNT(DISTINCT a.user_id) AS active_users
    FROM 
        cohort c
    JOIN 
        activity a ON c.user_id = a.user_id
    GROUP BY 
        c.cohort_week, a.activity_week
)
SELECT 
    cohort_week,
    activity_week,
    active_users,
    ROUND(100.0 * active_users / SUM(active_users) OVER (PARTITION BY cohort_week), 2) AS retention_rate
FROM 
    cohort_activity
ORDER BY 
    cohort_week, activity_week;


-- Weekly Engagement Per Device:
-- Objective: Measure the activeness of users on a weekly basis per device.
-- Your Task: Write an SQL query to calculate the weekly engagement per device.
SELECT 
    week_start,
    device,
    COUNT(DISTINCT user_id) AS active_users,
    COUNT(*) AS total_events,
    AVG(event_count) AS avg_events_per_user
FROM (
    SELECT 
        user_id,
        device, 
        DATE_TRUNC('week', occurred_at) AS week_start,
        COUNT(*) AS event_count
    FROM 
        events
    GROUP BY 
        user_id, device, DATE_TRUNC('week', occurred_at)
) AS user_device_activity
GROUP BY 
    week_start, device
ORDER BY 
    week_start, device
LIMIT 50000;



-- Email Engagement Analysis:
-- Objective: Analyze how users are engaging with the email service.
-- Your Task: Write an SQL query to calculate the email engagement metrics.
select * from email_events;
SELECT 
    DATE_TRUNC('week', occurred_at) AS week_start,
    action,
    COUNT(*) AS event_count,
    COUNT(DISTINCT user_id) AS unique_users
FROM 
    email_events
GROUP BY 
    DATE_TRUNC('week', occurred_at), action
ORDER BY 
    week_start, action;
