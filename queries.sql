SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species='';
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
-- Verify that the records were deleted
SELECT * FROM animals;
-- Rollback the transaction
ROLLBACK;
-- Verify that all records in the animals table still exist
SELECT * FROM animals;


BEGIN;
DELETE FROM animals WHERE birthdate > '2022-01-01';
SAVEPOINT update_weights;
UPDATE animals SET weight = weight * -1;
-- Verify that the change was made
SELECT * FROM animals;
-- Rollback to the savepoint
ROLLBACK TO update_weights;
-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight = weight * -1 WHERE weight < 0;
COMMIT;
-- Verify that the change was made and persists after commit
SELECT * FROM animals;


SELECT COUNT(*) FROM animals; -- How many animals are there?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0; -- How many animals have never tried to escape?

SELECT AVG(weight_kg) FROM animals; -- What is the average weight of animals?

SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered; -- Who escapes the most, neutered or not neutered animals?

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species; -- What is the minimum and maximum weight of each type of animal?

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escapes
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;





