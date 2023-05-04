INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Charmander', '2020-02-08', -11, false, 0, ''),
  ('Plantmon', '2021-11-15', -5.7, true, 2, ''),
  ('Squirtle', '1993-04-02', -12.13, false, 3, ''),
  ('Angemon', '2005-06-12', -45, true, 1, ''),
  ('Boarmon', '2005-06-07', 20.4, true, 7, ''),
  ('Blossom', '1998-10-13', 17, true, 3, ''),
  ('Ditto', '2022-05-14', 22, true, 4, ''),
  ('Agumon', '2020-02-03', 0, TRUE, 10.23, ""),
  ('Gabumon', '2018-11-15', 2, TRUE, 8), ""
  ('Pikachu', '2021-01-07', 1, FALSE, 15.04, ""),
  ('Devimon', '2017-05-12', 5, TRUE, 11, "");

  INSERT INTO owners (full_name, age) VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

  INSERT INTO species (name) VALUES
 ('Pokemon'),
 ('Digimon');

 UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';

 UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

 UPDATE animals SET species_id =
CASE
WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END,
owner_id =
CASE
WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08'); 

INSERT INTO specializations (vet_id, species_id) VALUES
(1, 1),
(3, 1),
(3, 2),
(4, 2);

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(7, 2, '2021-04-07'),
(8, 3, '2019-09-29'),
(9, 4, '2020-10-03'),
(9, 4, '2020-11-04'),
(10, 2, '2019-01-24'),
(10, 2, '2019-05-15'),
(10, 2, '2020-02-27'),
(10, 2, '2020-08-03'),
(11, 3, '2020-05-24'),
(11, 1, '2021-01-11');



