# Operational Metric Analytics
This project focuses on using SQL to analyze a company's end-to-end operations and investigate key business metrics.

## Tech Stack

**Language:** SQL  
**Tool:** MySQL Workbench  

## About
Operational Analytics is a crucial process that involves analyzing a company's operations to identify areas for improvement. As a Data Analyst, I work to derive valuable insights from collected data. One of the key aspects of Operational Analytics is investigating metric spikes, such as sudden changes in daily user engagement or sales figures. Understanding these fluctuations helps optimize business strategies.

In this project, I take on the role of a **Lead Data Analyst at a company like Microsoft**, working with various datasets to derive insights and answer business-critical questions. My goal is to leverage advanced SQL skills to analyze data, understand sudden metric changes, and improve operational efficiency.

---

## Case Study 1: Job Data Analysis
I will be working with a table named **job_data**, which contains the following columns:

- **job_id**: Unique identifier of jobs  
- **actor_id**: Unique identifier of actor  
- **event**: The type of event (decision/skip/transfer)  
- **language**: The language of the content  
- **time_spent**: Time spent reviewing the job (in seconds)  
- **org**: The organization of the actor  
- **ds**: The date in the format yyyy/mm/dd (stored as text)  

### Tasks
#### 1. Jobs Reviewed Over Time
- **Objective:** Calculate the number of jobs reviewed per hour for each day in **November 2020**.  
- **Task:** Write an SQL query to calculate jobs reviewed per hour.  

#### 2. Throughput Analysis
- **Objective:** Calculate the **7-day rolling average of throughput** (number of events per second).  
- **Task:** Write an SQL query to calculate the 7-day rolling average. Explain whether a daily metric or rolling average is preferable and why.  

#### 3. Language Share Analysis
- **Objective:** Calculate the **percentage share of each language** in the last **30 days**.  
- **Task:** Write an SQL query to calculate the language share.  

#### 4. Duplicate Rows Detection
- **Objective:** Identify duplicate rows in the dataset.  
- **Task:** Write an SQL query to display duplicate rows from the **job_data** table.  

---

## Case Study 2: Investigating Metric Spikes
I will be working with three tables:

1. **users** – Contains one row per user, with descriptive account details.  
2. **events** – Contains one row per event (e.g., login, messaging, search).  
3. **email_events** – Contains email-related events.  

### Tasks
#### 1. Weekly User Engagement
- **Objective:** Measure user activity on a **weekly basis**.  
- **Task:** Write an SQL query to calculate weekly user engagement.  

#### 2. User Growth Analysis
- **Objective:** Analyze **user growth over time** for the product.  
- **Task:** Write an SQL query to calculate user growth trends.  

#### 3. Weekly Retention Analysis
- **Objective:** Measure **weekly user retention** based on sign-up cohorts.  
- **Task:** Write an SQL query to calculate weekly retention rates.  

#### 4. Weekly Engagement Per Device
- **Objective:** Measure how often users engage with the platform **per device**.  
- **Task:** Write an SQL query to analyze user engagement based on device type.  

#### 5. Email Engagement Analysis
- **Objective:** Analyze how users interact with the email service.  
- **Task:** Write an SQL query to measure email engagement.  

---

## Insights On
- Job data trends and throughput analysis  
- Investigating metric spikes in user activity  
- Weekly engagement and retention patterns  
- Email interaction trends  

## More Information
This project was completed as part of the **[Trainity](https://trainity.in/data.html) Data Analytics Course**. For more details about my projects, visit my **[Trainity Profile](https://trainity.space/recruitersProfile/public/66e52eb6fd616408e13b683f)**.

