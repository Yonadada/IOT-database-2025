-- WorkBook : SQL Practice (pg544)
-- 샘플 문제 
/* Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력
	이때 이름과 성을 연결하여 Full Name 이라는 별칭으로 출력하시오
*/

SELECT employee_id,
	   concat(first_name,' ', last_name) AS "Full Name", 
       salary,
       job_id,
       hire_date,
       manager_id
  FROM employees;
  
/* 문제 1
   employee 에서 사원의 성과 이름을 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가해서 
   계산한 Increased Ann_Salary 급여에 $100 보너스를 추가해서 Increased Salary 별칭으로 출력하시오.
*/
SELECT concat(first_name,' ', last_name) AS "Name",
	   job_id AS "Job",
       salary AS "Salary",
       (salary * 12) + 100 AS "Increased Ann_Salary",
       (salary + 100) * 12 AS "Increased Salary"
  FROM employees; 
  

/* 문제 2번 
	Employees 에서 모든 사원이 last_name과 연봉을 '이름 : 1Year Salary = $연봉으로 출력하고, 
    1 Year Salary'라는 별칭을 붙이세요
*/
SELECT concat(last_name, ' : 1 Year Salary = $', (salary * 12)) AS "1 Year Salary"
  FROM employees;
  

/*
 문제 3번
 부서에 담당하는 업무를 한번씩만 출력하시오
*/
SELECT DISTINCT department_id, job_id
  FROM employees; 


