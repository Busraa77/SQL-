SELECT first_name, last_name, first_name || '.' || last_name || '@dbhunter.net' AS email , salary,salary* 0.35 AS bonus 
FROM employees;

SELECT * FROM employees
WHERE salary BETWEEN 5000 AND 10000;

-----------------bir filmin elenmesi için HER İKİ ŞARTIN DA AYNI ANDA SAĞLANMASI gerekir---------------------
SELECT job_id,salary FROM employees
WHERE NOT (salary BETWEEN 4000 and 7000 AND job_id IN (16));

--veya--

SELECT job_id,salary FROM employees
WHERE salary NOT BETWEEN 4000 AND 7000 
AND job_id NOT IN (16);

-------------------------NULL-------------------
--Null tanımlanmamış değerdir, 0 veya boşluk değildir.
--Null ile yapılan tüm işlemlerin sonucu null'dır.

SELECT * FROM employees
WHERE phone_number IS NOT NULL;