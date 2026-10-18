--postgresql aritmetik işlemleri tablo olarak döndürmeye imkan verir.
SELECT 8*5+4,
		120/4,
		current_date - 2;
		
---------------------------------------
SELECT title, 
	   length / 60,
	   2021-release_year
FROM film;

------------CONCATENATİON OPERATOR---------------------------
SELECT country_id || ':' || country
FROM country;

------------- ESCAPE CHARACTERS------------------------------------
-- başına E koyduğun ,fadede \ koyduğun yerden sonraki karakter string olur. Tırnak işareti için çok kullanılır çünkü özel bir manası var.
-- çift tırnak atsan da olur ama bu daha iyi
SELECT E'I\'m a computer engineer';

-- $$ arasına yazılan string ifadelerin karakterleri dikkate alınmaz aynı şekilde
SELECT $$ selam ' selam ' $$;

------------------ALİAS----------------
--as operatörü opsiyoneldir. okunabilirliği arttırır ancak mecburi değil.
SELECT first_name || ' ' || last_name full_name
FROM customer;

-----------------ORDER BY--------------------
--Sıralama maliyetli bir iştir. Büyük veriyle çalışıyosan dikkat.
SELECT * FROM film ORDER BY title ;
-- Varsayılan olarak asc(ascending-artan)

SELECT district,city_id
FROM address
ORDER BY address DESC; -- selectte olmayan veriye göre sıralayabilirsin.


SELECT district, address, city_id
FROM address
ORDER BY district, city_id DESC;
---Önce district (ilçe/bölge) sütununa göre A'dan Z'ye (ASC) sıralar.Aynı district değerine sahip olan adresleri kendi içinde city_id değerine göre büyükten küçüğe (DESC) dizilmesini sağlar.

SELECT * FROM customer ORDER BY 6 ;
-- select içindeki 6. kolona göre sıralama yap. Bu da biraz dezavantaj.


SELECT * FROM customer 
ORDER BY last_update NULLS FIRST; --or LAST

----------------------DISTINCT-----------------
--aynı veri varsa tek kez gelir.
--SQL'in çalışma ilkesi gereği tek bir tablo çıktısında bir sütun benzersiz (distinct) tutulurken yanına başka bir sütunu serbestçe dizemezsin.
SELECT
	DISTINCT address
FROM address;


-- distinct on --
--address,district satırını tekrarsız şekilde yazar. Addres değeri eşleşen tüm satırları teke düşürür ve bunlardan ilkinin district değerini alır.
SELECT DISTINCT ON (address) address,district
FROM address
ORDER BY address,district;

------------------------WHERE--------------------
SELECT * FROM actor
WHERE first_name= 'Penelope';

SELECT * FROM customer
WHERE store_id >= 2 ORDER BY customer_id;

SELECT * FROM film 
WHERE length > 100
	AND rental_duration < 5;

SELECT * FROM film
WHERE length 
	BETWEEN 90 AND 140;

SELECT * FROM film
WHERE NOT 
	(length BETWEEN 90 AND 140);

SELECT * FROM film
WHERE NOT 
	(length < 90 OR length > 140);

SELECT * FROM film
WHERE title BETWEEN 'A' AND 'F'
ORDER BY title;

SELECT return_date FROM rental 
WHERE DATE(return_date)  = '2005-05-30';

--IN: istediğin değerleri filtreleme
SELECT * FROM customer
WHERE customer_id IN (10,20);

--LIKE: % kaç karakter geldiği bilinmiyor hiç de olabilir, _:tek karakter gelecek.
SELECT first_name , last_name 
FROM customer 
WHERE first_name LIKE 'Ann%';

SELECT * FROM customer
WHERE first_name LIKE 'B____';

SELECT * FROM customer
WHERE first_name LIKE '_a%';

--ILIKE : Standart sql'de desteklenmez sadece postgresql'de. LIKE'IN cae insensitively hali.
SELECT first_name FROM customer
WHERE first_name ILIKE 'b%';


------
----- <> ile != eşitsizlik sorgulayabilirsin tek değer için.
----- x <> 16


select first_name,last_name,customer_id from customer c
where c.first_name NOT LIKE 'B%' and not customer_id >20;

----------------------------------LIMIT---------------------------
--fetch'de aynı işi yapar ama limit kullanımı daha kolay.
SELECT first_name,last_name
FROM customer
ORDER BY first_name
LIMIT 50 OFFSET 5; --ilk 5i atla 50 tane data ver.

----------------------------------------
----------------------------------------
----------------------------------------
---------------SQL FONKSİYONLARI----------


---LOWER(title),karşılaştırma yapılmadan veriyi arka planda geçici olarak küçük harfe çevirir: 'alone trip'
---Ardından LIKE '%trip' şartı aranır. 
SELECT * FROM film
WHERE LOWER(title) LIKE '%trip';

SELECT TITLE, 
	LOWER(TITLE) LO_TITLE,
	UPPER (TITLE) UP_TITLE,
	INITCAP(TITLE) IC_TITLE --KELİMELERİN BAŞ HARFLERİ BÜYÜK
FROM film;

----ILIKE ile de yazabilirsin..----
SELECT UPPER(title) AS title_new,LOWER(description) AS desc_new FROM film
 WHERE LOWER(description) LIKE '%drama%' 
 AND LOWER(description) LIKE '%australia%';



 ----------------------------------------------
 ------------------STRİNG FUNCTİONS------------
 ----------------------------------------------

 SELECT first_name,last_name,
 	 CONCAT(first_name,' ',last_name) as f1,
	 CONCAT_WS(',', first_name,last_name) as f2, --İlk parametreye verilen ayracı (separator) kullanarak, sonraki metin ifadelerini bu ayraçla birleştirir.
	 LEFT(first_name,1) as f3, --Belirtilen metnin sol başından başlayarak istenen sayıda karakteri kesip alır.
	 RIGHT(first_name,1) as f4,
	 LPAD(first_name, 14, '00') as f6,
	 RPAD(first_name,14,'00') as f7
FROM customer;


SELECT first_name,last_name,
	LENGTH(last_name) as f5,
	REPLACE(first_name,'e','*') as f8,
	-- tire ile böl 2. yi al.
	SPLIT_PART(create_date::varchar,'-',2) as f9, --belirtilen bir metni seçilen ayraç karaktere (delimiter) göre parçalara böler ve istenen sıradaki parçayı döndürür.
	SUBSTRING(last_name,2,3) as f10,
	POSITION('a' in first_name) as f11,
	REVERSE (first_name) as f12
FROM customer;