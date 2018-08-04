USE db_zoo

/* Compose a SELECT statement that queries all information from the habitat table */
SELECT * FROM tbl_habitat;

/* Compose a SELECT statement that queries for the following information: 
Retrieve all names from the species_name column that have a species_order value of 3. */
SELECT species_name FROM tbl_species WHERE species_order = 3;

/* Compose a SELECT statement that queries for the following information:
Retrieve only the nutrition_type from the nutrition table that have a nutrition_cost of 600.00 or less. */
SELECT nutrition_type FROM tbl_nutrition WHERE nutrition_cost <= 600;

/* Compose a SELECT statement that queries for the following information:
Retrieve all species_names with the nutrition_id between 2202 and 2206 from the nutrition table. */
SELECT species_name FROM tbl_species INNER JOIN tbl_nutrition 
ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id AND nutrition_id >= 2202 AND 
nutrition_id <= 2206;

/*Compose a SELECT statement that queries for the following information:
Retrieve all names within the species_name column using the alias "Species Name:" 
from the species table and their corresponding nutrition_type under the alias "Nutrition Type:" 
from the nutrition table.*/
SELECT species_name AS 'Species Name:', nutrition_type AS 'Nutrition Type:' 
FROM tbl_species INNER JOIN tbl_nutrition 
ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id;

/*Compose a SELECT statement that queries for the following information:
From the specialist table, retrieve the first and last name and contact number 
of those that provide care for the penguins from the species table.*/
SELECT specialist_fname, specialist_lname, specialist_contact
FROM tbl_specialist 
WHERE tbl_specialist.specialist_id = (SELECT tbl_care.care_specialist FROM tbl_care INNER JOIN tbl_species
ON tbl_care.care_id = tbl_species.species_care AND tbl_species.species_name LIKE '%penguin%');

/* Create a database with two tables. Assign a foreign key constraint on one table that 
shares related data with the primary key on the second table. 
Finally, create a statement that queries data from both tables. */
CREATE DATABASE drill_db;
USE [drill_db]

CREATE TABLE tbl_phones 
(
phone_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
phone_brand VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_carriers
(
carrier_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
carrier_name VARCHAR(40),
brand_supported INT NOT NULL CONSTRAINT fk_phone FOREIGN KEY REFERENCES tbl_phones(phone_id) 
ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO tbl_phones (phone_brand) VALUES ('HTC'),('Apple'),('Microsoft'),('LG'),('Samsung'),('ZTE');

INSERT INTO tbl_carriers (carrier_name, brand_supported) VALUES ('ATT',1),('VZN',6),('TM',2),('CKT',2),('SPR',3),('VDA',1);

SELECT phone_brand AS 'Brands not supported by any carrier in example' FROM tbl_phones LEFT JOIN tbl_carriers ON tbl_phones.phone_id = tbl_carriers.brand_supported WHERE tbl_carriers.brand_supported IS NULL;
