Select a.first_name, a.last_name
From sakila.actor as a;

select concat(upper(a.first_name),' ', upper(a.last_name)) as `Actor Name`
From sakila.actor as a;

Select a.actor_id, a.first_name, a.last_name
From sakila.actor as a
Where upper(a.first_name) = "JOE";

Select a.actor_id, a.first_name, a.last_name
From sakila.actor as a
Where upper(a.last_name) like "%GEN%";

Select a.actor_id, a.first_name, a.last_name
From sakila.actor as a
Where upper(a.last_name) like "%LI%"
Order By a.last_name, a.first_name;

Select c.country_id, c.country 
From sakila.country as c
Where upper(c.country) IN ("AFGHANISTAN", "BANGLADESH", "CHINA");

ALTER TABLE sakila.actor 
ADD column Description blob AFTER last_update ;

ALTER TABLE sakila.actor 
Drop column Description;

Select distinct a.last_name, count(a.last_name) as `Number`
From sakila.actor as a
Group By a.last_name;

Select distinct a.last_name, count(a.last_name) as `Number`
From sakila.actor as a
Group By a.last_name
Having count(a.last_name) > 1;

UPDATE sakila.actor
    SET sakila.actor.first_name = "Harpo"
    WHERE sakila.actor.actor_id = 172;
    
UPDATE sakila.actor
    SET sakila.actor.first_name = "Groucho"
    WHERE sakila.actor.first_name = "Harpo"
    AND sakila.actor.last_name = "Williams";

SHOW CREATE TABLE sakila.address;

Select s.first_name, s.last_name, a.address
From sakila.staff s
Inner Join sakila.address a ON s.address_id = a.address_id;

Select s.first_name, s.last_name, sum(p.amount) As `Total Paid`
From sakila.staff s
Inner Join sakila.payment p ON s.staff_id = p.staff_id
Group by s.staff_id ;

Select f.title, count(fa.actor_id) As `Total Actors`
From sakila.film f
Inner Join sakila.film_actor fa ON f.film_id = fa.film_id
Group by f.film_id ;

Select f.title, count(i.inventory_id) As `Total Copies`
From sakila.film f
Inner Join sakila.inventory i ON f.film_id = i.film_id
Where f.title = "Hunchback Impossible"
Group by f.film_id ;

Select c.first_name, c.last_name, sum(p.amount) As `Total Paid`
From sakila.customer c
Inner Join sakila.payment p ON c.customer_id = p.customer_id
Group by c.customer_id
order by c.last_name ;

Select f.title, l.name
From sakila.film f 
Join sakila.language l on f.language_id = l.language_id
Where f.film_id IN 
(select f.film_id
 From sakila.film f
join sakila.language l on f.language_id = l.language_id
where l.name = "English"
AND ( upper(f.title) like "K%"
     OR upper(f.title) like "Q%")
)
;

Select f.title as `Film Name`
, concat(a.first_name, ' ', a.last_name) AS `Actor Name`
From sakila.film f 
Join sakila.film_actor fa on f.film_id = fa.film_id
Join sakila.actor a On fa.actor_id = a.actor_id
Where f.film_id IN 
(select f.film_id
 From sakila.film f
where f.title = "Alone Trip"
);

Select f.title as `Film Name`
, concat(a.first_name, ' ', a.last_name) AS `Actor Name`
From sakila.film f 
Join sakila.film_actor fa on f.film_id = fa.film_id
Join sakila.actor a On fa.actor_id = a.actor_id
Where f.film_id IN 
(select f.film_id
 From sakila.film f
where f.title = "Alone Trip"
);

Select c.customer_id, c.first_name, c.last_name, c.email
from sakila.customer c
join sakila.address a on c.address_id = a.address_id
join sakila.city ct on a.city_id = ct.city_id
join sakila.country cty on ct.country_id = cty.country_id
Where upper(cty.country) = "CANADA"
;

Select f.title as `Film Title`, cat.name as `Category`
From sakila.film f 
Join sakila.film_category fc on f.film_id = fc.film_id
Join sakila.category cat on fc.category_id = cat.category_id 
Where cat.name = "Family"
;

Select f.title as `Film Title`, count(r.rental_id) As `Total Rents`
From sakila.film f 
Join sakila.inventory i on f.film_id = i.film_id
Join sakila.rental r on i.inventory_id = r.inventory_id
Group by (f.film_id)
order by count(r.rental_id) Desc
;

select s.store_id as `Store`, sum(p.amount) as `Total Sales`
From sakila.store s
join sakila.customer c ON s.store_id = c.store_id
join sakila.payment p On c.customer_id = p.customer_id
Group by s.store_id
;
;

Select s.store_id, ct.city, cty.country
from sakila.store s
join sakila.address a on s.address_id = a.address_id
join sakila.city ct on a.city_id = ct.city_id
join sakila.country cty on ct.country_id = cty.country_id
;

Select cat.name as `Category`, sum(p.amount) As `Total Sales`
From sakila.film f 
Join sakila.film_category fc on f.film_id = fc.film_id
Join sakila.category cat on fc.category_id = cat.category_id
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
join sakila.payment p on r.rental_id = p.rental_id
Group by cat.category_id
Order by sum(p.amount) Desc
Limit  5;

CREATE VIEW sakila.Category_Sales AS
Select cat.name as `Category`, sum(p.amount) As `Total Sales`
From sakila.film f 
Join sakila.film_category fc on f.film_id = fc.film_id
Join sakila.category cat on fc.category_id = cat.category_id
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
join sakila.payment p on r.rental_id = p.rental_id
Group by cat.category_id
Order by sum(p.amount) Desc
Limit  5;

SELECT * FROM sakila.Category_Sales;

SHOW CREATE VIEW sakila.Category_Sales;

DROP VIEW sakila.Category_Sales;






