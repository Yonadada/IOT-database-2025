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


/*
 샘플 문제 (Pg546)
 hr 부서 예산 편성 문제로 급여 정보 보고서를 작성한다.
 employees에서 salary가 7000 ~ 10000달러 범위 외의 사람의 성과 이름을 Name,
 급여가 작은 순서로 출력한다(75행)

*/
SELECT CONCAT(first_name, ' ', last_name) AS 'Name', 
	   salary
  FROM employees
 WHERE salary NOT BETWEEN 7000 AND 10000
 order by salary;
 

/*
	 문제 1번
     사원의 성(last_name), 중에 e 및 o 글자를 포함된 사원을 출력하시오.
     이때 머리글(컬럼명)은 e AND o Name이라고 출력하시오(10행)
*/

SELECT last_name AS "e AND o Name"
  FROM employees
 WHERE last_name LIKE'%e%' AND last_name LIKE '%o%'; 


/*
	문제 2
    현재 날짜 타입을 날짜 함수를 통해 확인하고 1995년 5월 20일부터 1996년 5월 20일 사이에 고용된 
    사람들의 이름을 Name, 사원번호, 고용일자를 출력하시오
    단, 입사일이 빠른 순으로 정렬하시오.(8행)
*/

  SELECT   employee_id,
		   CONCAT(first_name, ' ', last_name) AS 'Name',
		   hire_date
	FROM   employees
   WHERE   hire_date BETWEEN '1995-05-20' AND '1996-05-20' -- DATE 타입은 문자열처럼 조건연산을 해도 된다 
ORDER BY   hire_date DESC;

SELECT date_add(sysdate(), interval 9 hour) AS 'sysdate()';



-- ========================================
-- Pg549
/*
	문제 1번
    이름이 s로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다(18행)
    출력시 성과 이름은 첫 글자를 대문자로, 업무는 대문자로 출력하고 머리글은 Employee JOBs,로 표시

*/

SELECT CONCAT(first_name, ' ', last_name, ' is a ', upper(job_id)) AS "Employee JOBs"
  FROM employees
 WHERE last_name like '%s';
 
 
/*
	pg 550
	문제 3
    사원의 성과 이름을 Name으로 별칭, 입사일, 입사한 요일을 출력하시오.
    이때 주(Week) 시작인 일요일부터 출력되도록 정렬 (107행)

*/

SELECT   CONCAT(first_name, ' ', last_name) AS 'Name',
	     hire_date,
		 date_format(hire_date, '%W') AS "Day of the week"
	FROM employees
ORDER BY date_format(hire_date, '%w')asc, hire_date;



-- =========================================
-- 집계함수
-- pg 551
/*
	문제1
    사원이 소속된 부서별 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계.
    출력값은 여섯자리와 세자리 구분기호, $표시 포함, 부서번호를 오름차순
    단, 부서에 소속되지 않는 사원은 정보에서 제외, 출력시 머리글은 아래처럼 별칭으로 처리(11개행)
*/

SELECT 	 department_id,
		 concat('$',format(round(sum(salary),0),0)) AS "Sum Salary",
         concat('$',format(round(avg(salary),1),1)) AS "Avg Salary", -- round(값, 1) , 소수점 1자리에서 반올림 /  format(값, 1) 소수점표현 및 1000단위 , 표시
         concat('$',format(round(max(salary),0),0)) AS "Max Salary",
         concat('$',format(round(min(salary),0),0)) AS "Min Salary"
    FROM employees
   WHERE department_id IS NOT NULL 
GROUP BY department_id -- 그룹바이 속한 컬럼만 select 절에 사용할 수 있음!
ORDER BY department_id;



-- ===================================
-- join(조인)
/*
	문제 2
    job_grades 테이블을 사용, 각 사원의 급여에 따른 급여등급을 보고한다.
    이름과 성을 Name으로 별칭, 업무, 부서명, 입사일, 급여, 급여등급을 출력하시오(106)
*/
DESC job_grades;
desc employees;

-- ANSI Standard SQL 쿼리 -> 잘 사용안함
SELECT *
  FROM 	departments as d JOIN employees as e
	ON  d.department_id = e.department_id;


SELECT   CONCAT(e.first_name, ' ', e.last_name) AS 'Name',
		 e.job_id,
         d.department_name,
         e.hire_date,
         e.salary,
         (select grade_level from job_grades -- 함수를 넣어도 되고, case 가능, 서브쿼리
           where e.salary between lowest_sal and highest_sal) AS "grade level" 
  FROM 	 departments as d, employees as e
 WHERE   d.department_id = e.department_id
ORDER BY e.salary DESC;

-- 서브쿼리 테스트
SELECT * FROM job_grades where 2560 between lowest_sal and highest_sal;


/*
	문제3
    각 사원의 상사와의 관계를 이용, 보고서 작성을 하려고 함
	예를 보고 출력하시오(107행)

*/
SELECT CONCAT(e2.first_name, ' ', e2.last_name) AS "Employee",
	   ' report to ',
       UPPER(CONCAT(e1.first_name, ' ', e2.last_name)) AS "Manager"
  FROM employees AS e1 LEFT JOIN employees AS e2
    ON e1.employee_id = e2.manager_id;



-- ============================================
-- 서브쿼리
-- pg 557
/*
	문제3
    사원들의 지역별 근무 현황을 조회하고자 한다. 
    도시 이름이 영문 O 로 시작하는 지역에 살고 있는 사원의 사번, 성과이름을 Name, 업무, 입사일 출력하시오(34행)
*/
SELECT e.employee_id,
	   CONCAT(e.first_name, ' ', e.last_name),
       e.job_id,
       e.hire_date
  FROM employees AS e, departments AS d
 WHERE e.department_id = d.department_id
   AND d.location_id = (SELECT location_id
						  FROM locations
						 WHERE city LIKE 'o%');
                         
-- 서브쿼리 테스트
SELECT location_id
FROM locations
WHERE city LIKE 'o%'


 
 
SELECT * FROM employees;
SELECT * FROM departments;

