# In this lab, you will be using the Sakila database of movie rentals.
USE sakila;

# 1. Drop column picture from staff.
ALTER TABLE staff DROP COLUMN picture;

#2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = "Tammy" AND last_name = "Sanders";

INSERT INTO staff
VALUES ("Tammy", "Sanders", 79, "tammy.sanders@sakilastaff.com", 2, "Tammy", "ws12345");

SELECT *
FROM staff;

#3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table.
SELECT customer_id FROM customer
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';

SELECT inventory_id FROM inventory
WHERE film_id = (
  SELECT film_id FROM film
  WHERE title = 'Academy Dinosaur'
) AND store_id = 1;

SELECT film_id FROM film
WHERE title = 'Academy Dinosaur';

SELECT staff_id FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW, 1, 130, 1);

# 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

# Check if there are any non-active users
SELECT DISTINCT active
FROM customer;

SELECT *
FROM customer
WHERE active = 0;

# Create a table backup table as suggested
CREATE TABLE backup_table (
    customer_id INT,
    email VARCHAR(50),
    delete_date DATE
);

# Insert the non active users in the table backup table
INSERT INTO backup_table (customer_id, email, delete_date) VALUES
(16, "SANDRA.MARTIN@sakilacustomer.org", NOW()),
(64, "JUDITH.COX@sakilacustomer.org", NOW()),
(124, "SHEILA.WELLS@sakilacustomer.org", NOW()),
(169, "ERICA.MATTHEWS@sakilacustomer.org", NOW()),
(241, "HEIDI.LARSON@sakilacustomer.org", NOW()),
(271, "PENNY.NEAL@sakilacustomer.org", NOW()),
(315, "KENNETH.GOODEN@sakilacustomer.org", NOW()),
(368, "HARRY.ARCE@sakilacustomer.org", NOW()),
(406, "NATHAN.RUNYON@sakilacustomer.org", NOW()),
(446, "THEODORE.CULP@sakilacustomer.org", NOW()),
(482, "MAURICE.CRAWLEY@sakilacustomer.org", NOW()),
(510, "BEN.EASTER@sakilacustomer.org", NOW()),
(534, "CHRISTIAN.JUNG@sakilacustomer.org", NOW()),
(558, "JIMMIE.EGGLESTON@sakilacustomer.org", NOW()),
(592, "TERRANCE.ROUSH@sakilacustomer.org", NOW());

SELECT *
FROM backup_table;

# Delete the non active users from the table customer
SET FOREIGN_KEY_CHECKS=0;

DELETE FROM customer
WHERE active = 0;

SELECT *
FROM customer
WHERE active = 0;

