-- Insert initial seed data for tbl_types
INSERT INTO tbl_types (id, typeName) VALUES
(1, 'Grass'),
(2, 'Fire'),
(3, 'Water'),
(4, 'Electric'),
(5, 'Psychic'),
(6, 'Fighting'),
(7, 'Darkness'),
(8, 'Metal'),
(9, 'Fairy'),
(10, 'Dragon'),
(11, 'Colorless');

-- Insert initial seed data for tbl_stages
INSERT INTO tbl_stages (id, stageName) VALUES
(1, 'Basic'),
(2, 'Stage 1'),
(3, 'Stage 2');

-- Insert initial seed data for tbl_collections
INSERT INTO tbl_collections (id, collectionsSetName, releaseDate, totalCardsInCollections) VALUES
(1, 'Base Set', '1999-01-09', 102),
(2, 'Jungle', '1999-06-16', 64),
(3, 'Fossil', '1999-10-10', 62);

-- Insert initial seed data for tbl_cards
INSERT INTO tbl_cards (id, hp, name, info, attack, dammage, weak, ressis, retreat, cadsNumberInColletion, collection_id, type_id, stage_id) VALUES
(1, 60, 'Bulbasaur', 'Seed Pokémon', 'Tackle', '10', 'Fire', 'Water', '1', 1, 1, 1, 1),
(2, 80, 'Charmeleon', 'Flame Pokémon', 'Flamethrower', '50', 'Water', 'None', '2', 5, 1, 2, 2),
(3, 90, 'Blastoise', 'Shellfish Pokémon', 'Hydro Pump', '60', 'Electric', 'None', '3', 9, 1, 3, 3);
