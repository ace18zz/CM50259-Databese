CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), checkups SMALLINT UNSIGNED, birth DATE, death DATE);

INSERT INTO pet (name,owner,species,sex,checkups,birth,death)VALUES
('Fluffy','Harold','cat','f',5,'2001-02-04',NULL),
('Claws','Gwen','cat','m',2,'2000-03-17',NULL),
('Buffy','Harold','dog','f',7,'1999-05-13',NULL),
('Fang','Benny','dog','m',4,'2000-08-27',NULL),
('Bowser','Diane','dog','m',8,'1998-08-31','2001-07-29'),
('Chirpy','Gwen','bird','f',0,'2002-09-11',NULL),
('Whistler','Gwen','bird','',1,'2001-12-09',NULL),
('Slim','Benny','snake','m',5,'2001-04-29',NULL);

--Q1-1
SELECT name, owner FROM pet WHERE sex = "f";
--Q1-2. The names and birth dates of pets which are dogs. 
SELECT name, birth FROM pet WHERE species = "dog";
--Q1-3. The names of the owners of birds.
SELECT owner FROM pet WHERE species = "bird";
--Q1-4. The species of pets who are female.
SELECT species FROM pet WHERE sex = "f";
--Q1-5. The names and birth dates of pets which are cats or birds. 
SELECT name,birth FROM pet WHERE species = "bird" OR species = "cat";
--Q1-6. The names and species of pets which are cats or birds and which are female.
SELECT name,species FROM pet WHERE sex = "f" AND (species = "bird" OR species = "cat");


--Q2-1. The names of owners and their pets where the pet's name ends with “er” or “all” 
SELECT name, owner FROM pet WHERE name LIKE "%er" OR "%all";

--Q2-2. The names of any pets whose owner's name contains an "e" 
SELECT name FROM pet WHERE owner LIKE "%e%";
--Q2-3. The names of all pets whose name does not end with "fy" 
SELECT name FROM pet WHERE name NOT LIKE "%fy";
--Q2-4. All pet names whose owners name is only four characters long
SELECT name FROM pet WHERE length(owner) = 4;
--Q2-5. All owners whose names begin and end with one of the first five letters of the alphabet 

--SELECT SUBSTR(owner,1,1)result FROM pet WHERE result LIKE "[a-e]" ;
SELECT owner FROM pet WHERE (SUBSTR (UPPER(owner),1,1) BETWEEN "A" AND "E") AND (SUBSTR (UPPER(owner),-1,1) BETWEEN "A" AND "E");

--Q2-6. Repeat the previous query, but make the query sensitive to the case of letters of the alphabet the characters in the name (NOTE: This query is not part of the assessed coursework!)


--Q3-1. The average number of check-ups that each owner has made with their pets 
SELECT AVG(checkups) AS CountAverage FROM pet;
--Q3-2. The number of pets of each species in ascending order
SELECT species FROM pet GROUP BY species order by species desc;
--Q3-3. The number of pets of each species that each owner has
SELECT COUNT(*), species,owner FROM pet GROUP BY species;
--Q3-4. The number of distinct species of pet each owner has 
SELECT COUNT(*),owner FROM pet GROUP BY owner;
--Q3-5. The number of pets of each gender there are in the database, where the gender is known 
SELECT COUNT(*),sex FROM pet GROUP BY sex;

--Q3-6. The number of birds each owner has 
SELECT COUNT(*),species,owner FROM pet WHERE species = "bird" GROUP BY owner;

--Q3-7. The total number of check-ups each owner has made with all their pets 
SELECT SUM(checkups),owner FROM pet GROUP BY owner;