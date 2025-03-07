-- 실무 실습 계속

-- 서브쿼리 계속alter
/*
	문제1
    사원의 급여 정보 중 업무별(job) 최소 급여를 받는 사원의 성과 이름(Name 별칭),
    업무, 급여, 입사일을 출력하시오(21행)
*/

desc jobs;
select * from jobs; 
select * from employees; 

SELECT CONCAT(e1.first_name, ' ', e1.last_name) AS 'Name'
	 , e1.job_id
     , concat('$',format(round(e1.salary),0)) as salary
     , e1.hire_date
  FROM employees AS e1
 WHERE (e1.job_id, e1.salary) IN (SELECT e.job_id,
										 MIN(e.salary) AS salary
								    FROM employees AS e
								  GROUP BY e.job_id);
                                  

-- ===================================
-- 집합 연산자 : 테이블 내용을 합쳐서 조회 -> 혼자서 해봐야함 


-- ===================================
-- 조건부 논리 표현식 제어 : CASE 
/*
	샘플 문제1
    HR 부서에서 프로젝트를 성공으로 급여인상이 결정됨
    사원현재 107명 19개 업무에 소속되어 근무중
    회사 업무 Distince job_id 5개 업무에서 일하는 사원
    HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%) 외 나머지 부서는 동결 (107행)
*/

SELECT employee_id,
	   CONCAT(first_name, ' ', last_name) AS 'Name',
       job_id,
       salary,
       CASE job_id WHEN 'HR_REP' THEN salary * 1.10 
				   WHEN 'MK_REP' THEN salary * 1.12
                   WHEN 'PR_REP' THEN salary * 1.15
                   WHEN 'SA_REP' THEN salary * 1.18
                   WHEN 'IT_PROG'THEN salary * 1.20
                   ELSE salary
       END AS "New Salary"
  FROM employees;
  
  
  
  /*
	문제 3
    월별로 입사한 사원수가 아래와 같이 행별로 출력되도록 하시오.(12행)
  */
  
  -- 형변환 함수 CAST(), CONVERT()
SELECT cast('-09' as unsigned); -- unsigned (양수만 숫자형)
SELECT convert('-09', signed); -- signed (음수 포함 숫자형)
SELECT convert(00009, char);
SELECT convert('248542', date);


-- 컬럼을 입사일 중 월만 추출해서 숫자로 변경
SELECT CONVERT(DATE_FORMAT(hire_date, '%m'), signed)
  FROM employees
GROUP BY CONVERT(DATE_FORMAT(hire_date, '%m'), signed);
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- group by 필요
select @@sql_mode;
   
-- CASE문 사용 1월부터 12월까지 expand  
-- case문 사용 1월부터 12월까지 expand
select case convert(date_format(hire_date, '%m'), signed) when 1 then count(*) else 0 end as '1월' -- 1월 만들어서 나머지는 복사 수정
     , case convert(date_format(hire_date, '%m'), signed) when 2 then count(*) else 0 end as '2월'
     , case convert(date_format(hire_date, '%m'), signed) when 3 then count(*) else 0 end as '3월'
     , case convert(date_format(hire_date, '%m'), signed) when 4 then count(*) else 0 end as '4월'
     , case convert(date_format(hire_date, '%m'), signed) when 5 then count(*) else 0 end as '5월'
     , case convert(date_format(hire_date, '%m'), signed) when 6 then count(*) else 0 end as '6월'
    , case convert(date_format(hire_date, '%m'), signed) when 7 then count(*) else 0 end as '7월'
     , case convert(date_format(hire_date, '%m'), signed) when 8 then count(*) else 0 end as '8월'
     , case convert(date_format(hire_date, '%m'), signed) when 9 then count(*) else 0 end as '9월'
     , case convert(date_format(hire_date, '%m'), signed) when 10 then count(*) else 0 end as '10월'
     , case convert(date_format(hire_date, '%m'), signed) when 11 then count(*) else 0 end as '11월'
     , case convert(date_format(hire_date, '%m'), signed) when 12 then count(*) else 0 end as '12월'
  from employees
  group by convert(date_format(hire_date, '%m'), signed)
  order by convert(date_format(hire_date, '%m'), signed) asc;
  
  
-- ===================================
-- Rollup
/*
	샘플
    부서와 업무별 급여합계를 구하고 신년도 급여수준 레벨을 지정하려고 함
    부서 번호와 업무를 기준으로 전 해 행을 그룹별로 나누어 급여합계와 인원수를 출력(20개행)

*/
SELECT department_id, job_id
	 , concat('$',format(sum(salary),0)) as 'Salary SUM'
     , count(employee_id) as 'COUNT EMPs'
  FROM employees
GROUP BY department_id, job_id
with rollup; -- group by에 컬럼이 하나면 총계는 하나, 컬럼이 두개면 첫번째 컬럼별로 소계, 두 컬럼의 합산이 총계로

/*
	문제1 
    이전 문제를 활용, 집계결과가 아니면 (ALL-DEPTs)라고 출력
    업무에 대한 집계결과가 아니면 (ALL-JOBs)를 출력
    rollup으로 만들어진 소계면 (ALL-JOBs), 총계면 (ALL-DEPTs)
*/
SELECT case grouping(department_id) when 1 then '(ALL-DEPTs)' else ifnull(department_id, '부서없음') end as 'Dept#'
	 , case grouping(job_id) when 1 then '(ALL-JOBs)' else job_id end as 'Jobs'
	 , concat('$',format(sum(salary),0)) as 'Salary SUM'
     , count(employee_id) as 'COUNT EMPs'
 --  , grouping(department_id) -- group by와 with rollup 을 사용할 때 그룹핑이 어떻게 되는지 확인하는 함수
 --  , grouping(job_id)
	 , format(avg(salary) * 12, 0)as 'Avg Ann_sal'
  FROM employees
GROUP BY department_id, job_id
with rollup;

-- ====================================
-- Rank()
/*
	샘플 
    분석함수 NTILE() 사용, 부서별 급여 합계를 구하시오
    급여가 제일 큰 것이 1, 제일 작은 것이 4가 되도록 등급을 나눔(12행)
*/
select department_id
	 , sum(salary) as 'Sum Salary'
     , ntile(6) over (order by sum(salary) desc) as 'Bucket#'
  from employees
group by department_id;

-- Dens Rank
/*
	문제1
    부서별 급여를 기준으로 내림차순 정렬하시오
    이때 다음 세가지 함수를 이용하여 순위를 출력하시오(107행)
    
*/
select employee_id
	 , last_name
	 , salary
     , department_id
     , rank() over (partition by department_id order by salary desc) as 'Rank' -- 1,1,3 순위매기기 rank(즉, 공동n등이 있으면 다음 순위가 빠지고 카운트됨)
	 , dense_rank() over(partition by department_id order by salary desc) as 'Dense Rank' -- 1,1,2 순위매기기 (즉, 공동n등이 있더라도 순차적으로 순위를 매긴다)
	 , row_number() over(partition by department_id order by salary desc) as 'Row Number' -- 행 번호 매기기
  from employees
order by department_id asc, salary desc;