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

-- Who was the last animal seen by William Tatcher?
SELECT name FROM
 ((SELECT animal_id, visit_date
 FROM ((SELECT id FROM vets WHERE name = 'William Tatcher') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit
 ORDER BY visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT name FROM
 ((SELECT animal_id, visit_date
 FROM ((SELECT id FROM vets WHERE name = 'Stephanie Mendez') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name as specialties
FROM vets
FULL JOIN specializations ON vets.id = specializations.vet_id
FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT name FROM
 ((SELECT animal_id, visit_date
 FROM ((SELECT id FROM vets WHERE name = 'Stephanie Mendez') vets 
 JOIN visits ON vets.id = visits.vet_id)) will_vets
 JOIN animals ON will_vets.animal_id = animals.id) as visit
 WHERE visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, Count(*) AS total_visits
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY total_visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT name FROM
((SELECT animal_id, visit_date 
FROM ((SELECT id FROM vets WHERE name = 'Maisy Smith') vets 
JOIN visits ON vets.id = visits.vet_id)) will_vets
JOIN animals ON will_vets.animal_id = animals.id) as visit
ORDER BY visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT *
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
ORDER BY visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits JOIN
(SELECT vets.id
FROM vets
FULL JOIN specializations ON vets.id = specializations.vet_id
FULL JOIN species ON species.id = specializations.species_id
WHERE specializations.species_id IS NULL) vet 
ON vet.id = visits.vet_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT name, COUNT(*) AS total
FROM (SELECT animals.species_id FROM (SELECT id FROM vets WHERE name = 'Maisy Smith') as vet
JOIN visits ON visits.vet_id = vet.id
JOIN animals ON animals.id = visits.animal_id) as all_visits
JOIN species ON all_visits.species_id = species.id
GROUP BY name 
ORDER BY total DESC LIMIT 1;





