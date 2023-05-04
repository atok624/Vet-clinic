CREATE TABLE animals (
    id SERIAL PRIMARY KEY not null,
    name varchar(100) not null,
    date_of_birth date not null,
    escape_attempts int not null,
    neutered bool not null,
    weight_kg decimal not null
);

ALTER TABLE animals ADD species varchar(255);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals
  ADD COLUMN species_id INTEGER,
  ADD COLUMN owner_id INTEGER,
  DROP COLUMN species,
  ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id),
  ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);


